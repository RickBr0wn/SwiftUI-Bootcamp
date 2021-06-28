//
//  GeometryReader_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 28/06/2021.
//

import SwiftUI

struct GeometryReader_: View {
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(0..<20) { index in
          GeometryReader { geometryProxy in
            RoundedRectangle(cornerRadius: 20.0)
              .rotation3DEffect(
                Angle(degrees: getPercentage(geometryProxy: geometryProxy) * 40),
                axis: (x: 0.0, y: 1.0, z: 0.0)
              )
          }
          .frame(width: 300, height: 250)
          .padding()
        }
      }
    }
  }
  
  private func getPercentage(geometryProxy: GeometryProxy) -> Double {
    let maximumDistance = UIScreen.main.bounds.width / 2
    let curentXPosition = geometryProxy.frame(in: .global).midX
    return Double(1 - (curentXPosition / maximumDistance))
  }
  
  private var geometryReaderExampleOne: some View {
    GeometryReader { geometryProxy in
      HStack(spacing: 0) {
        Rectangle()
          .fill(Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)))
          .frame(width: geometryProxy.size.width * 0.66)
        
        Rectangle()
          .fill(Color(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)))
      }
      .edgesIgnoringSafeArea(.all)
    }
  }
}

struct GeometryReader__Previews: PreviewProvider {
  static var previews: some View {
    GeometryReader_()
  }
}
