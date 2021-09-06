//
//  AnyTransition_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 06/09/2021.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
  let rotation: Double
  
  func body(content: Content) -> some View {
    content
      .rotationEffect(Angle(degrees: rotation))
      .offset(
        x: rotation != 0 ? UIScreen.main.bounds.width : 0,
        y: 0)
  }
}

extension AnyTransition {
  static var rotating: AnyTransition {
    return AnyTransition.modifier(
      active: RotateViewModifier(rotation: 180),
      identity: RotateViewModifier(rotation: 0))
  }
  
  static func rotating(rotation: Double) -> AnyTransition {
    return AnyTransition.modifier(
      active: RotateViewModifier(rotation: rotation),
      identity: RotateViewModifier(rotation: 0))
  }
  
  static var rotateOn: AnyTransition {
    return AnyTransition.asymmetric(insertion: AnyTransition.rotating, removal: .move(edge: .leading))
  }
  
}



struct AnyTransition_: View {
  @State private var showRectangle: Bool = false
  
  var body: some View {
    VStack {
      Spacer()
      
      if showRectangle {
        RoundedRectangle(cornerRadius: 25.0)
          .frame(width: 250, height: 350)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .transition(.rotateOn)
      }
      
      Spacer()
      
      Text("Click Me")
        .withDefaultButtonFormatting()
        .padding(.horizontal, 40)
        .onTapGesture {
          withAnimation(.easeInOut(duration: 2.0)) {
            showRectangle.toggle()
          }
        }
    }
  }
}

struct AnyTransition__Previews: PreviewProvider {
  static var previews: some View {
    AnyTransition_()
  }
}
