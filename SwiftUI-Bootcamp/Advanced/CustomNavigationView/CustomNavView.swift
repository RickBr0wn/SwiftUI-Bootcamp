//
//  CustomNavView.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 16/11/2021.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
  let content: Content
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    NavigationView {
      CustomNavBarContainerView {
        content.edgesIgnoringSafeArea(.all)
      }
      .navigationBarHidden(true)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

extension UINavigationController {
  open override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = nil
  }
}

struct CustomNavView_Previews: PreviewProvider {
  static var previews: some View {
    CustomNavView {
      ZStack {
        Color.orange
      }
    }
  }
}
