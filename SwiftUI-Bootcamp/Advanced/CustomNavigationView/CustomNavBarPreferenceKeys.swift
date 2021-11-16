//
//  CustomNavBarPreferenceKeys.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 16/11/2021.
//

import Foundation
import SwiftUI

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
  static var defaultValue: String = ""
  
  static func reduce(value: inout String, nextValue: () -> String) {
    value = nextValue()
  }
}

struct CustomNavBarSubTitlePreferenceKey: PreferenceKey {
  static var defaultValue: String? = nil
  
  static func reduce(value: inout String?, nextValue: () -> String?) {
    value = nextValue()
  }
}

struct CustomNavBarBackButtonHiddenPreferenceKey: PreferenceKey {
  static var defaultValue: Bool = false
  
  static func reduce(value: inout Bool, nextValue: () -> Bool) {
    value = nextValue()
  }
}

extension View {
  /// Configures the view's title for purposes of navigation, using a string.
  ///
  /// Use `customNavigationTitle(_:)` to display a title for the
  /// navigation bar view.
  ///
  /// This modifier only takes effect when this view is inside of and visible
  /// within a ``CustomNavView``.
  ///
  /// - Parameter title: The string to display.
  func customNavigationTitle(_ title: String) -> some View {
    preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
  }
  /// Configures the view's sub headline for purposes of navigation, using a string.
  ///
  /// Use `customNavigationSubTitle(_:)` to display a sub headline for the
  /// navigation bar view.
  ///
  /// This modifier only takes effect when this view is inside of and visible
  /// within a ``CustomNavView``.
  ///
  /// - Parameter subtitle: The string to display.
  func customNavigationSubTitle(_ subtitle: String?) -> some View {
    preference(key: CustomNavBarSubTitlePreferenceKey.self, value: subtitle)
  }
  /// Hides the navigation bar back button for the view.
  ///
  /// Use `customNavigationBackButtonHidden(_:)` to hide the back button for this
  /// view.
  ///
  /// This modifier only takes effect when this view is inside of and visible
  /// within a ``CustomNavView``.
  ///
  /// - Parameter hidesBackButton: A Boolean value that indicates whether to
  ///   hide the back button.
  func customNavigationBackButtonHidden(_ hidesBackButton: Bool) -> some View {
    preference(key: CustomNavBarBackButtonHiddenPreferenceKey.self, value: hidesBackButton)
  }
  /// Defines all of the parameters for a Custom Nav View.
  ///
  /// Use  `customNavBarItems(title: ,subtitle: ,hidesBackButton: )` to customize the
  /// the ``CustomNavBarView``.
  ///
  /// This modifier only takes effect when this view is inside of and visible
  /// within a ``CustomNavView``.
  ///
  /// - Parameter title: The string to display.
  /// - Parameter subtitle: The string to display.
  /// - Parameter hidesBackButton: A Boolean value that indicates whether to
  ///   hide the back button.
  func customNavBarItems(title: String = "", subtitle: String? = nil, hidesBackButton: Bool = false) -> some View {
    self
      .customNavigationTitle(title)
      .customNavigationSubTitle(subtitle)
      .customNavigationBackButtonHidden(hidesBackButton)
  }
}
