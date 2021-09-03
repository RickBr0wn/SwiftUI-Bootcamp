//
//  Gradients_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 11/06/2021.
//

import SwiftUI

struct Gradients_: View {
  var body: some View {
    VStack {
      RoundedRectangle(cornerRadius: 25.0)
        .fill(
          LinearGradient(
            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))]),
            startPoint: .topLeading,
            endPoint: .trailing)
        )
        .frame(width: 300, height: 200, alignment: .center)
      
      RoundedRectangle(cornerRadius: 25.0)
        .fill(
          RadialGradient(
            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))]),
            center: .topTrailing,
            startRadius: 5,
            endRadius: 200
          )
        )
        .frame(width: 300, height: 200, alignment: .center)
      
      RoundedRectangle(cornerRadius: 25.0)
        .fill(
          AngularGradient(
            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))]),
            center: .topLeading,
            angle: .degrees(100 + 45)
          )
        )
        .frame(width: 300, height: 200, alignment: .center)
    }
  }
}

struct Gradients__Previews: PreviewProvider {
  static var previews: some View {
    Gradients_()
  }
}
