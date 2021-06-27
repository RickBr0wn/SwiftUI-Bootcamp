//
//  MagnificationGesture_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 26/06/2021.
//

import SwiftUI

struct MagnificationGesture_: View {
  @State private var currentAmountOfScale: CGFloat = 0.0
  @State private var lastAmount: CGFloat = 0.0
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Circle().frame(width: 35, height: 35)
        Text("Magnification Gestures")
        Spacer()
        Image(systemName: "ellipsis")
      }
      .padding(.horizontal)
      
      Rectangle()
        .frame(height: 300)
        .scaleEffect(currentAmountOfScale + 1)
        .gesture(
          MagnificationGesture()
            .onChanged { value in
              currentAmountOfScale = value - 1
            }
            .onEnded { value in
              withAnimation(.spring()) {
                currentAmountOfScale = 0
              }
            }
        )
      
      HStack {
        Image(systemName: "heart.fill")
        Image(systemName: "text.bubble.fill")
        Spacer()
      }
      .padding(.horizontal)
      .font(.headline)
      
      Text("This is the caption for the Image!")
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
  }
}

extension MagnificationGesture_ {
  private var exampleOne: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      .font(.title)
      .padding(40)
      .background(Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)).cornerRadius(10.0))
      .scaleEffect(1.0 + currentAmountOfScale + lastAmount)
      .gesture(
        MagnificationGesture()
          .onChanged { value in
            self.currentAmountOfScale = value
            
          }
          .onEnded { value in
            lastAmount += currentAmountOfScale
            currentAmountOfScale = 0
          }
      )
  }
}

struct MagnificationGesture__Previews: PreviewProvider {
  static var previews: some View {
    MagnificationGesture_()
  }
}
