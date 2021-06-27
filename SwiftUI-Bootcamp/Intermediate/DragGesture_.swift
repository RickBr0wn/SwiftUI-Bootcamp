//
//  DragGesture_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 27/06/2021.
//

import SwiftUI

struct DragGesture_: View {
  @State private var offset: CGSize = .zero
  
  var body: some View {
    ZStack {
      VStack {
        Text("\(offset.width)")
        Spacer()
      }
      
      RoundedRectangle(cornerRadius: 25.0)
        .frame(width: 300, height: 500)
        .offset(offset)
        .scaleEffect(getScaleAmount())
        .rotationEffect(Angle(degrees: getRotationAmount()))
        .gesture(
          DragGesture()
            .onChanged { value in
              withAnimation(.spring()) {
                offset = value.translation
              }
            }
            .onEnded { value in
              withAnimation(.spring()) {
                offset = .zero
              }
            }
        )
    }
  }
  
  func getScaleAmount() -> CGFloat {
    let maximumAmount = UIScreen.main.bounds.width / 2
    let currentAmount = abs(offset.width)
    let percentage = currentAmount / maximumAmount
    return 1.0 - min(percentage, 0.5) * 0.5
  }
  
  func getRotationAmount() -> Double {
    let maximumAmount = UIScreen.main.bounds.width / 2
    let currentAmount = offset.width
    let percentage = currentAmount / maximumAmount
    let percentageAsDouble = Double(percentage)
    let maximumAngle: Double = 10.0
    return percentageAsDouble * maximumAngle
  }
}

struct DragGesture__Previews: PreviewProvider {
  static var previews: some View {
    DragGesture_()
  }
}
