//
//  Color_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 11/06/2021.
//

import SwiftUI

struct Color_: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 25.0)
      .fill(
        Color("CustomColor")
      // Color(UIColor.secondarySystemBackground)
      // Color.primary
      // Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
      )
      .frame(width: 300, height: 200)
      .shadow(color: Color.red, radius: 10, x:10, y: 10)
  }
}

struct Color__Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Color_()
      
      Color_()
        .preferredColorScheme(.dark)
    }
  }
}
