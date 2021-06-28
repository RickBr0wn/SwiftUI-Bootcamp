//
//  Haptics_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 28/06/2021.
//

import SwiftUI

class HapticManager {
  static let instance = HapticManager()
  
  func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
  }
  
  func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
  }
}

struct Haptics_: View {
  var body: some View {
    VStack(spacing: 20) {
      Divider()
      Button("success".uppercased()) { HapticManager.instance.notification(type: .success) }
      Button("warning".uppercased()) { HapticManager.instance.notification(type: .warning) }
      Button("error".uppercased()) { HapticManager.instance.notification(type: .error) }
      Divider()
      Button("heavy".uppercased()) { HapticManager.instance.impact(style: .heavy) }
      Button("light".uppercased()) { HapticManager.instance.impact(style: .light) }
      Button("medium".uppercased()) { HapticManager.instance.impact(style: .medium) }
      Button("rigid".uppercased()) { HapticManager.instance.impact(style: .rigid) }
      Button("soft".uppercased()) { HapticManager.instance.impact(style: .soft) }
    }
  }
}

struct Haptics__Previews: PreviewProvider {
  static var previews: some View {
    Haptics_()
  }
}
