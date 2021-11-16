//
//  CustomNavBarContainerView.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 16/11/2021.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
  let content: Content
  @State private var showBackButton: Bool = true
  @State private var title: String = ""
  @State private var subtitle: String? = nil
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    VStack(spacing: 0) {
      CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
      content
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .onPreferenceChange(CustomNavBarTitlePreferenceKey.self) { value in
      self.title = value
    }
    .onPreferenceChange(CustomNavBarSubTitlePreferenceKey.self) { value in
      self.subtitle = value
    }
    .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self) { value in
      self.showBackButton = !value
    }
  }
}

struct CustomerNavBarContainerView_Previews: PreviewProvider {
  static var previews: some View {
    CustomNavBarContainerView {
      ZStack {
        Color.green.edgesIgnoringSafeArea(.all)
        Text("Hello WOrld!!")
      }
      .customNavigationTitle("New Title")
      .customNavigationSubTitle("Sub Title!!")
      .customNavigationBackButtonHidden(true)
    }
  }
}
