//
//  TabBarItemsPreferenceKey.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 08/11/2021.
//

import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey {
  static var defaultValue: Array<TabBarItem> = []
  
  static func reduce(value: inout Array<TabBarItem>, nextValue: () -> Array<TabBarItem>) {
    value += nextValue()
  }
}


struct TabBarItemViewModifier: ViewModifier {
  @Binding var selection: TabBarItem
  let tab: TabBarItem
  
  func body(content: Content) -> some View {
    content
      .opacity(selection == tab ? 1.0 : 0.0)
      .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
  }
}

extension View {
  func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
    self.modifier(TabBarItemViewModifier(selection: selection, tab: tab))
  }
}
