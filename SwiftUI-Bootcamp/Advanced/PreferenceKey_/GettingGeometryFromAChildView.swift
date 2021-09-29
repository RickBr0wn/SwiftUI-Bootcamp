//
//  GettingGeometryFromAChildView.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 29/09/2021.
//

import SwiftUI

struct GettingGeometryFromAChildView: View {
  @State private var rectSize: CGSize = .zero
  
  var body: some View {
    VStack {
      Text("From child component.\n  width: \(self.rectSize.width), \n  height: \(self.rectSize.height)")
        .frame(width: .infinity)
        .background(Color.blue)
      
      Spacer()
      HStack {
        GeometryReader { proxy in
          Rectangle()
        }
        GeometryReader { proxy in
          Rectangle()
            .updateRectangleGeometrySize(proxy.size)
            .overlay(Text("\(proxy.size.width)")
                      .foregroundColor(.white)
            )
        }
        GeometryReader { proxy in
          Rectangle()
        }
      }
      .frame(height: 55)
    }
    .onPreferenceChange(RectangleGeometryPreferenceKey.self) { value in
      self.rectSize = value
    }
  }
}

struct RectangleGeometryPreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

extension View {
  func updateRectangleGeometrySize(_ size: CGSize) -> some View {
    self.preference(key: RectangleGeometryPreferenceKey.self, value: size)
  }
}

struct GettingGeometryFromAChildView_Previews: PreviewProvider {
  static var previews: some View {
    GettingGeometryFromAChildView()
  }
}
