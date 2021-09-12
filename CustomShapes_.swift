//
//  CustomShapes_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 12/09/2021.
//

import SwiftUI
/*
 Coordinate System on iPhone
 
 minX,minY  midX,minY  maxX,minY
 minX,midY  midX,midY  maxX,midY
 minX,maxY  midX,maxY  maxX,maxY
 */
  

struct Triangle: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.midX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    }
  }
}

struct Diamond: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      let horizontalOffset: CGFloat = rect.width * 0.2 // 20%
      
      path.move(to: CGPoint(x: rect.midX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
      path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
    }
  }
}

struct Trapezoid: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      let horizontalOffset: CGFloat = rect.width * 0.2 // 20%
      
      path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
      path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
    }
  }
}

struct CustomShapes_: View {
  var body: some View {
    ZStack {
      Trapezoid()
        .fill(Color.blue)
        .frame(width: 300, height: 150, alignment: .center)
    }
  }
}

struct CustomShapes__Previews: PreviewProvider {
  static var previews: some View {
    CustomShapes_()
  }
}
