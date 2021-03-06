//
//  PreferenceKey.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 29/09/2021.
//

import SwiftUI

struct PreferenceKey_: View {
  @State private var text: String = "Some random text!"
  
  var body: some View {
    NavigationView {
      VStack {
        SecondaryView(text: text)
          .navigationBarTitle("Navigation Title")
          .customTitle("New Value!")
      }
    }
    .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
      self.text = value
    }
  }
}

extension View {
  func customTitle(_ text: String) -> some View {
    self.preference(key: CustomTitlePreferenceKey.self, value: text)
  }
}

struct SecondaryView: View {
  let text: String
  
  var body: some View {
    Text(text)
      
  }
}

struct CustomTitlePreferenceKey: PreferenceKey {
  static var defaultValue: String = ""
  
  static func reduce(value: inout String, nextValue: () -> String) {
    value = nextValue()
  }
}

struct PreferenceKey__Previews: PreviewProvider {
  static var previews: some View {
    PreferenceKey_()
  }
}
