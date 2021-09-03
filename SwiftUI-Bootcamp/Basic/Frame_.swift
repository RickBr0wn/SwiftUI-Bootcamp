//
//  Frame_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 24/06/2021.
//

import SwiftUI

struct Frame_: View {
  var body: some View {
    Text("Inspecting frames in SwiftUI")
      // .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
      // .background(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
      // .frame(width: 300, height: 250, alignment: .bottomTrailing)
      // .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      // .background(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
      // .edgesIgnoringSafeArea(.all)
      .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
      .frame(height: 100)
      .background(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
      .frame(width: 300)
      .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
      .frame(maxWidth: .infinity)
      .background(Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)))
      .frame(height: 400)
      .background(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
      .frame(maxHeight: .infinity)
      .background(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
      .edgesIgnoringSafeArea(.all)
  }
}

struct Frame__Previews: PreviewProvider {
  static var previews: some View {
    Frame_()
  }
}
