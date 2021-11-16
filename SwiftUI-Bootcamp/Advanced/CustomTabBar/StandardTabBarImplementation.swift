//
//  StandardTabBarImplementation.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 02/11/2021.
//

import SwiftUI

struct StandardTabBarImplementation: View {
  @State private var selected: String = "home"
  @State private var tabSelection: TabBarItem = .home
  
  var body: some View {
    CustomTabBarContainerView(selection: $tabSelection) {
      Color.red
        .tabBarItem(tab: .home, selection: $tabSelection)
      
      Color.blue
        .tabBarItem(tab: .account, selection: $tabSelection)
      
      Color.green
        .tabBarItem(tab: .settings, selection: $tabSelection)
    }
  }
}

extension StandardTabBarImplementation {
  private var defaultTabView: some View {
    TabView(selection: $selected) {
      Color.red.edgesIgnoringSafeArea(.top)
        .tabItem {
          Image(systemName: "house")
          Text("home".capitalized)
        }
      
      Color.blue.edgesIgnoringSafeArea(.top)
        .tabItem {
          Image(systemName: "person")
          Text("account".capitalized)
        }
      
      
      Color.green.edgesIgnoringSafeArea(.top)
        .tabItem {
          Image(systemName: "gear")
          Text("settings".capitalized)
        }
      
    }
  }
}

struct StandardTabBarImplementation_Previews: PreviewProvider {
  static var previews: some View {
    StandardTabBarImplementation()
  }
}
