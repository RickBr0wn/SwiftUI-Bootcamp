//
//  CustomTabBarImplementation.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 02/11/2021.
//

import SwiftUI

struct CustomTabBarView: View {
  let tabs: Array<TabBarItem>
  @Binding var selection: TabBarItem
  @Namespace private var namespace
  @State var localSelection: TabBarItem
 
  var body: some View {
    tabBarVersionTwo
      .onChange(of: selection) { value in
        withAnimation(.easeInOut) {
          localSelection = value
        }
      }
  }
}

extension CustomTabBarView {
  private func tabView(tab: TabBarItem) -> some View {
    VStack {
      Image(systemName: tab.iconName)
        .font(.subheadline)
      
      Text(tab.title.capitalized)
        .font(.system(size: 10.0, weight: .semibold, design: .rounded))
    }
    .foregroundColor(localSelection == tab ? tab.color : Color.gray)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity)
    .background(localSelection == tab ? tab.color.opacity(0.2) : Color.clear)
    .cornerRadius(10.0)
  }
  
  private func switchToTab(tab: TabBarItem) -> Void {
//    withAnimation(.easeInOut) { selection = tab }
    selection = tab
  }
  
  private var tabBarVersionOne: some View {
    HStack {
      ForEach(tabs, id: \.self) { tab in
        tabView(tab: tab)
          .onTapGesture { switchToTab(tab: tab) }
      }
    }
    .padding(6)
    .background(Color.white.edgesIgnoringSafeArea(.bottom))
  }
  
  private func tabViewTwo(tab: TabBarItem) -> some View {
    VStack {
      Image(systemName: tab.iconName)
        .font(.subheadline)
      
      Text(tab.title.capitalized)
        .font(.system(size: 10.0, weight: .semibold, design: .rounded))
    }
    .foregroundColor(localSelection == tab ? tab.color : Color.gray)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity)
    .background(
      ZStack {
        if localSelection == tab {
          RoundedRectangle(cornerRadius: 10.0)
            .fill(tab.color.opacity(0.2))
            .matchedGeometryEffect(id: "background_rectangle", in: namespace)
        }
      }
    )
  }
  
  private var tabBarVersionTwo: some View {
    HStack {
      ForEach(tabs, id: \.self) { tab in
        tabViewTwo(tab: tab)
          .onTapGesture { switchToTab(tab: tab) }
      }
    }
    .padding(6)
    .background(Color.white.edgesIgnoringSafeArea(.bottom))
    .cornerRadius(10.0)
    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
    .padding(.horizontal)
  }
}

struct CustomTabBarView_Previews: PreviewProvider {
  static let tabs: Array<TabBarItem> = [.home, .account, .settings]
  
  static var previews: some View {
    VStack {
      Spacer()
      CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
    }
  }
}
