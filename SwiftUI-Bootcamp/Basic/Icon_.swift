//
//  Icon_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 11/06/2021.
//

import SwiftUI

struct Icon_: View {
  var body: some View {
    Image(systemName: "person.fill.badge.plus")
      .renderingMode(.original)
    // .resizable()
    // .aspectRatio(contentMode: .fit)
    // .scaledToFit()
     .font(.largeTitle)
    // .font(.system(size: 48))
    // .frame(width: 200, height: 200)
    // .foregroundColor(.green)
  }
}

struct Icon__Previews: PreviewProvider {
  static var previews: some View {
    Icon_()
  }
}

