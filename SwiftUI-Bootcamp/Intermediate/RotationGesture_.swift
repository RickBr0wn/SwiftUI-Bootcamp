//
//  RotationGesture_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 27/06/2021.
//

import SwiftUI

struct RotationGesture_: View {
  @State private var angle: Angle = Angle(degrees: .zero)
  
  var body: some View {
    Text("Hello, World!")
      .font(.largeTitle)
      .fontWeight(.semibold)
      .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
      .padding(50)
      .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
      .cornerRadius(25.0)
      .rotationEffect(angle)
      .gesture(
        RotationGesture()
          .onChanged { newAngle in
            angle = newAngle
          }
          .onEnded({ _ in
            withAnimation(.spring()) {
              angle = Angle(degrees: .zero)
            }
          })
      )
  }
}

struct RotationGesture__Previews: PreviewProvider {
  static var previews: some View {
    RotationGesture_()
  }
}
