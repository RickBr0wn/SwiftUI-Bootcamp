//
//  AnimationCurves_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 14/09/2021.
//

import SwiftUI

let timing: Double = 10.0

struct AnimationExample: View {
  let name: String
  var isAnimating: Bool
  let animation: Animation
  
  init(boolean isAnimating: Bool, animation: Animation) {
    self.isAnimating = isAnimating
    self.animation = animation
    
    switch animation {
    case .linear(duration: timing):
      self.name = ".default"
    case .easeIn(duration: timing):
      self.name = ".easeIn"
    case .easeOut(duration: timing):
      self.name = ".easeOut"
    case .easeInOut(duration: timing):
      self.name = ".easeInOut"
    case .spring():
      self.name = ".spring()"
    case .spring(response: 3.0, dampingFraction: 0.5, blendDuration: 1.0):
      self.name = ".spring(response: 3.0, dampingFraction: 0.5, blendDuration: 1.0)"
    default:
      self.name = "unknown"
    }
  }
  
  var body: some View {
    Divider()
    
    Text(name)
      .font(.subheadline)
      .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
    
    RoundedRectangle(cornerRadius: 25.0)
      .frame(width: isAnimating ? 350 : 50, height: 100)
      .animation(animation == .spring(response: 3.0, dampingFraction: 0.5, blendDuration: 1.0) ? .spring(response: 3.0, dampingFraction: 0.5, blendDuration: 1.0) : animation)
  }
}

struct AnimationCurves_: View {
  @State private var isAnimating: Bool = false
  
  var body: some View {
    VStack {
      Button("Button") {
        isAnimating.toggle()
      }
      
      AnimationExample(boolean: isAnimating, animation: .linear(duration: timing))
      AnimationExample(boolean: isAnimating, animation: .easeIn(duration: timing))
      AnimationExample(boolean: isAnimating, animation: .easeOut(duration: timing))
      AnimationExample(boolean: isAnimating, animation: .easeInOut(duration: timing))
      // AnimationExample(boolean: isAnimating, animation: .spring())
      
      Divider()
      
      Text(".spring(response: dampingFraction: blendDuration: ")
        .font(.subheadline)
        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
      
      RoundedRectangle(cornerRadius: 25.0)
        .frame(width: isAnimating ? 350 : 50, height: 100)
        .animation(.spring(response: 1.0, dampingFraction: 0.2, blendDuration: 1.0))

    }
  }
}

struct AnimationCurves__Previews: PreviewProvider {
  static var previews: some View {
    AnimationCurves_()
  }
}
