//
//  CustomeShapesWithArcsAndQuadCurves_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 14/09/2021.
//

import SwiftUI

/*
 minX,minY  midX,minY  maxX,minY
 minX,midY  midX,midY  maxX,midY
 minX,maxY  midX,maxY  maxX,maxY
 */

// Always remember Angle(degrees: ) starts from 3 on a clock face and NOT 12

struct ArcExample: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
      path.addArc(
        center: CGPoint(x: rect.midY, y: rect.midY),
        radius: rect.width / 2,
        startAngle: Angle(degrees: 0),
        endAngle: Angle(degrees: 40),
        clockwise: true
      )
    }
  }
}

struct ShapeWithArc: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      // top left
      path.move(to: CGPoint(x: rect.minX, y: rect.minY))
      // top right
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
      // mid right
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
      // bottom
      // path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
      path.addArc(
        center: CGPoint(x: rect.midX, y: rect.midY),
        radius: rect.height / 2,
        startAngle: Angle(degrees: 0),
        endAngle: Angle(degrees: 180),
        clockwise: false
      )
      // mid left
      path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
      // top left
      path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
    }
  }
}

struct ShapeWithQuadCurve: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: .zero)
      path.addQuadCurve(
        to: CGPoint(x: rect.midX, y: rect.midY),
        control: CGPoint(x: rect.maxX - 50, y: rect.minY - 100)
      )
    }
  }
}

struct WaterShape: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.minX, y: rect.midY))
      path.addQuadCurve(
        to: CGPoint(x: rect.midX, y: rect.midY),
        control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.40)
      )
      path.addQuadCurve(
        to: CGPoint(x: rect.maxX, y: rect.midY),
        control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.60)
      )
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    }
  }
}

struct CustomeShapesWithArcsAndQuadCurves_: View {
  var body: some View {
    WaterShape()
    // .rotation(Angle(degrees: 90))
    // .stroke(lineWidth: 5)
    // .frame(width: 200, height: 200)
      .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))]), startPoint: .top, endPoint: .bottom))
      .edgesIgnoringSafeArea(.all)
  }
}

struct CustomeShapesWithArcsAndQuadCurves__Previews: PreviewProvider {
  static var previews: some View {
    CustomeShapesWithArcsAndQuadCurves_()
  }
}

