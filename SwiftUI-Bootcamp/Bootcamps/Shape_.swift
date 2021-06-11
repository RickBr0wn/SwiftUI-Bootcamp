//
//  Shape_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 11/06/2021.
//

import SwiftUI

struct Shape_: View {
  var body: some View {
    Circle()
    // .fill(Color.green)
    // .foregroundColor(.pink)
    // .stroke()
    // .stroke(Color.blue)
    // .stroke(Color.blue, lineWidth: 50)
    // .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round, dash: [30]))
    /// Can be used for loader
    // .trim(from: 0, to: 1.0)
    // .stroke(Color.purple, lineWidth: 10)
  }
}

struct Shape__Previews: PreviewProvider {
  static var previews: some View {
    Shape_()
  }
}
