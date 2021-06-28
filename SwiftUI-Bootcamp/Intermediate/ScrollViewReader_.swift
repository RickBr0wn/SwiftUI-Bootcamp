//
//  ScrollViewReader_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 27/06/2021.
//

import SwiftUI

struct ScrollViewReader_: View {
  @State private var itemNumber: String = ""
  @State private var scrollToIndex: Int = .zero
  
  var body: some View {
    VStack {
      TextField("Enter an item number", text: $itemNumber)
        .frame(height: 55)
        .border(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
        .padding(.horizontal)
        .keyboardType(.numberPad)
      
      Button("Scroll now".uppercased()) {
        withAnimation(.spring()) {
          if let index = Int(itemNumber) {
            scrollToIndex = index
          }
        }
      }
      
      ScrollView {
        ScrollViewReader() { proxy in
          Button("Click her to got to item #30") {
            withAnimation(.spring()) {
              proxy.scrollTo(30, anchor: .top)
            }
          }
          ForEach(0..<50) { index in
            Text("Item #\(index)")
              .font(.headline)
              .frame(height: 200)
              .frame(maxWidth: .infinity)
              .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
              .cornerRadius(20.0)
              .shadow(radius: 10.0)
              .padding()
              .id(index)
          }
          .onChange(of: scrollToIndex) { value in
            withAnimation(.spring()) {
              proxy.scrollTo(value, anchor: .center)
            }
          }
        }
      }
    }
  }
}

struct ScrollViewReader__Previews: PreviewProvider {
  static var previews: some View {
    ScrollViewReader_()
  }
}
