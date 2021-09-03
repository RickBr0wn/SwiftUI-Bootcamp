//
//  ViewModifiers_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 03/09/2021.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
  let backgroundColor: Color
  
  func body(content: Content) -> some View {
    content
      .foregroundColor(.white)
      .frame(height: 55)
      .frame(maxWidth: .infinity)
      .background(backgroundColor)
      .cornerRadius(10.0)
      .shadow(radius: 10)
  }
}

extension View {
  func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
    modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
  }
}

struct ViewModifiers_: View {
  var body: some View {
    VStack(spacing: 10) {
      Text("Hello World")
        .font(.headline)
        .withDefaultButtonFormatting(backgroundColor: .orange)
      
      Text("Hello everyone!")
        .font(.headline)
        .withDefaultButtonFormatting()
      
      Text("Hello!!")
        .font(.title)
        .withDefaultButtonFormatting(backgroundColor: .red)
    }
    .padding()
  }
}

struct ViewModifiers__Previews: PreviewProvider {
  static var previews: some View {
    ViewModifiers_()
  }
}
