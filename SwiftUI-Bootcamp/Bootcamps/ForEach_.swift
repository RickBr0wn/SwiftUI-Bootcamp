//
//  ForEach_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 24/06/2021.
//

import SwiftUI

struct ForEach_: View {
  
  var body: some View {
    VStack {
      ForEach(1..<10) {
        Text("Number \($0)")
          .frame(width: 100, height: 100, alignment: .center)
          .background(Color.red)
          .clipShape(Circle())
          .foregroundColor(.white)
      }
    }
  }
}

struct ForEach__Previews: PreviewProvider {
  static var previews: some View {
    ForEach_()
  }
}
