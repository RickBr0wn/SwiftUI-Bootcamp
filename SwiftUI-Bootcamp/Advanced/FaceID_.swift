//
//  FaceID_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 04/12/2021.
//

import LocalAuthentication
import SwiftUI

// requires Privacy - FaceID.. in info.plist
struct FaceID_: View {
  @State private var isUnlocked: Bool = false
  
  var body: some View {
    VStack {
      if self.isUnlocked {
        Text("Unlocked")
      } else {
        Text("Locked")
      }
    }
    .onAppear(perform: authenticate)
  }
  
  func authenticate() -> Void {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "We need to unlock your data."
      
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
        DispatchQueue.main.async {
          if success {
            // success
            self.isUnlocked = true
          } else {
            // fail
          }
        }
      }
    } else {
      // no biometrics
    }
  }
}

struct FaceID__Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
