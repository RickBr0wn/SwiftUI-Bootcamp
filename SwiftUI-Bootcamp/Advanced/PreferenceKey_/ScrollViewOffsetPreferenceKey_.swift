//
//  ScrollViewOffsetPreferenceKey_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 29/09/2021.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}

extension View {
  func onScrollViewOffsetChange(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
    self.background(GeometryReader { proxy in
      Text("")
        .preference(key: ScrollViewOffsetPreferenceKey.self, value: proxy.frame(in: .global).minY)
    })
      .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
        action(value)
      }
  }
}

struct ScrollViewOffsetPreferenceKey_: View {
  let title: String = "New title!!!"
  @State private var scrollViewOffset: CGFloat = .zero
  
  var body: some View {
    ScrollView {
      VStack {
        titleLayer
          .opacity(Double(scrollViewOffset) / 63.0)
          .onScrollViewOffsetChange { offset in
            self.scrollViewOffset = offset
          }
        contentLayer
      }
      .padding()
    }
    .overlay(Text("\(scrollViewOffset)"))
    .overlay(navBarLayer.opacity(scrollViewOffset < 40 ? 1.0 : 0.0), alignment: .top)
  }
}

extension ScrollViewOffsetPreferenceKey_ {
  private var titleLayer: some View {
    Text(title)
      .font(.largeTitle)
      .fontWeight(.semibold)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var contentLayer: some View {
    ForEach(0..<100) { _ in
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.red.opacity(0.3))
        .frame(width: 300, height: 200)
    }
  }
  
  private var navBarLayer: some View {
    Text(title)
      .font(.headline)
      .frame(maxWidth: .infinity)
      .frame(height: 55)
      .background(Color.blue)
  }
}

struct ScrollViewOffsetPreferenceKey__Previews: PreviewProvider {
  static var previews: some View {
    ScrollViewOffsetPreferenceKey_()
  }
}
