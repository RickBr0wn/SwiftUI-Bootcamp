//
//  ScrollView_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 24/06/2021.
//

import SwiftUI

struct ScrollView_: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(1..<10) { _ in
          ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
              ForEach(1..<10) { _ in
                RoundedRectangle(cornerRadius: 25.0)
                  .fill(Color.white)
                  .frame(width: 200, height: 150)
                  .shadow(radius: 10)
                  .padding()
              }
            }
          }
        }
      }
    }
  }
}

struct ScrollView__Previews: PreviewProvider {
  static var previews: some View {
    ScrollView_()
  }
}
