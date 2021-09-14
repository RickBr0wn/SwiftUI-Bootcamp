//
//  Animations_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 14/09/2021.
//

import SwiftUI

struct Animations_: View {
  @State private var isAnimated: Bool = false
  
  var body: some View {
    VStack {
      Button("Button") {
        //  withAnimation(.spring().repeatForever(autoreverses: true)) {
        //    isAnimated.toggle()
        //  }
        isAnimated.toggle()
      }
      
      Spacer()
      
      RoundedRectangle(cornerRadius: isAnimated ? 150 : 25.0)
        .fill(isAnimated ? Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)) : Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
        .frame(width: isAnimated ? 100 : 200, height: isAnimated ? 100 : 200)
        .rotationEffect(isAnimated ? Angle(degrees: 720) : Angle(degrees: 0))
        .offset(y: isAnimated ? 300 : 0)
        // this line is used when only the Rectangle should be animated, and not the variable
        .animation(.easeIn)
      
      
      Spacer()
    }
  }
}

struct Animations__Previews: PreviewProvider {
  static var previews: some View {
    Animations_()
  }
}
