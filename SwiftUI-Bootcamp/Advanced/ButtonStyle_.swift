//
//  ButtonStyle_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 03/09/2021.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
  let scale: Double
  
  init(scale: Double) {
    self.scale = scale
  }
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .opacity(configuration.isPressed ? scale : 1.0)
      // .brightness(configuration.isPressed ? 0.3 : 0.0)
      .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
  }
}

extension View {
  
  func withPressableButtonStyle(scaledAmount: Double = 0.9) -> some View {
    self.buttonStyle(PressableButtonStyle(scale: scaledAmount))
  }
}

struct ButtonStyle_: View {
  var body: some View {
    Button(action: {}, label: {
      Text("Click Me!!")
        .font(.headline)
        .withDefaultButtonFormatting()
    })
    // .withPressableButtonStyle()
    .withPressableButtonStyle(scaledAmount: 0.9)
    .padding(40)
  }
}

struct ButtonStyle__Previews: PreviewProvider {
  static var previews: some View {
    ButtonStyle_()
  }
}
