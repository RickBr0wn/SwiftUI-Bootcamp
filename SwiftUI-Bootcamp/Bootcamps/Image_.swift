//
//  Image_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 24/06/2021.
//

import SwiftUI

struct Image_: View {
  var body: some View {
    VStack {
      Image("gecko")
        // .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .foregroundColor(.green)
        .padding()
      
      Image("logo")
        .resizable()
        .frame(width: 200, height: 200)
        // .cornerRadius(25.0)
        .clipShape(Circle())
    }
  }
}

struct Image__Previews: PreviewProvider {
  static var previews: some View {
    Image_()
  }
}
