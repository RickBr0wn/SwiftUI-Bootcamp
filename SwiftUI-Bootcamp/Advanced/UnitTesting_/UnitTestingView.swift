//
//  UnitTestingView.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 26/10/2021.
//

import SwiftUI

/*
 Unit Tests - Business Logic in the app (ViewModels, Managers, Services etc.)
 
 UI Tests - Tests the UI of the app
 */
struct UnitTestingView: View {
  @StateObject private var vm: UnitTestingViewModel
  
  init(isPremium: Bool) {
    _vm = StateObject(wrappedValue: UnitTestingViewModel(isPremium: isPremium))
  }
  
  var body: some View {
    Text(vm.isPremium.description)
  }
}

struct UnitTestingView_Previews: PreviewProvider {
  static var previews: some View {
    UnitTestingView(isPremium: true)
  }
}
