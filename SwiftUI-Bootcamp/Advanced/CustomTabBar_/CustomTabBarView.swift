//
//  CustomTabBarView.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 30/09/2021.
//

import SwiftUI

struct CustomTabBarView: View {
  let tabs: Array<CustomTabBarItem>
  @Binding var selection: CustomTabBarItem
  
  var body: some View {
    HStack {
      ForEach(tabs, id: \.self) { tab in
        CustomTabView(tab: tab, selection: selection)
          .onTapGesture { switchTo(tab: tab) }
      }
    }
    .padding(6)
    .background(Color.white.edgesIgnoringSafeArea(.bottom))
  }
  
  private func switchTo(tab: CustomTabBarItem) -> Void {
    withAnimation(.easeInOut) { selection = tab }
  }
}

struct CustomTabBarItem: Hashable {
  let iconName: String
  let title: String
  let color: Color
}

struct CustomTabView: View {
  @State var tab: CustomTabBarItem
  var selection: CustomTabBarItem
  
  var body: some View {
    VStack {
      Image(systemName: tab.iconName)
        .font(.subheadline)
      Text(tab.title)
        .font(.system(size: 10, weight: .semibold, design: .rounded))
    }
    .foregroundColor(selection == tab ? tab.color : Color.gray)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity)
    .background(selection == tab ? tab.color.opacity(0.2) : Color.gray.opacity(0.1))
    .cornerRadius(10.0)
  }
}

extension PreviewProvider {
  static var dev: DeveloperPreview {
    DeveloperPreview.instance
  }
}

class DeveloperPreview {
  static let instance = DeveloperPreview()
  
  let tabs: Array<CustomTabBarItem> = [
    CustomTabBarItem(iconName: "house", title: "Home", color: .blue),
    CustomTabBarItem(iconName: "gear", title: "Settings", color: .green),
    CustomTabBarItem(iconName: "person", title: "Profile", color: .yellow)
  ]
  
  @State var selection: CustomTabBarItem = CustomTabBarItem(iconName: "house", title: "Home", color: .blue)
}

struct CustomTabBarView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      CustomTabBarView(tabs: dev.tabs, selection: .constant(dev.selection))
        .padding()
    }
  }
}
