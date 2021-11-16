//
//  TabBarItem.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 09/11/2021.
//
import Foundation
import SwiftUI

//struct TabBarItem: Hashable {
//  let iconName: String
//  let title: String
//  let color: Color
//}

// using the Hashable protocol so that the TabBarItems can be used in a ForEach loop
enum TabBarItem: Hashable {
   case home, account, settings
  
  var iconName: String {
    switch self {
    case .home:
      return "house"
    case .account:
      return "person"
    case .settings:
      return "gear"
    }
  }
  
  var title: String {
    switch self {
    case .home:
      return "home"
    case .account:
      return "account"
    case .settings:
      return "settings"
    }
  }
  
  var color: Color {
    switch self {
    case .home:
      return .red
    case .account:
      return .blue
    case .settings:
      return .green
    }
  }
}
