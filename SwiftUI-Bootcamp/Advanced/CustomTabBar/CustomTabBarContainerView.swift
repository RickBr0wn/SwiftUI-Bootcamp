//
//  CustomTabBarContainerView.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 07/11/2021.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
  @Binding var selection: TabBarItem
  
  let content: Content
  
  @State private var tabs: Array<TabBarItem> = []
  
  init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
    self._selection = selection
    self.content = content()
  }
  
  var body: some View {
    ZStack(alignment: .bottom) {
      content.edgesIgnoringSafeArea(.all)
      
      CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
    }
    .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
      self.tabs = value
    }
  }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
  static let tabs: Array<TabBarItem> = [.home, .account, .settings]
  
  static var previews: some View {
    CustomTabBarContainerView(selection: .constant(tabs.first!)) {
      Color.red
    }
  }
}
