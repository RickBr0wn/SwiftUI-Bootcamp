//
//  Mask_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 28/06/2021.
//

import SwiftUI

struct Mask_: View {
  @State private var rating: Int = 0
  
  var body: some View {
    ZStack {
      rowOfRatingsStars
        .overlay(overlayView.mask(rowOfRatingsStars))
    }
  }
  
  private var overlayView: some View {
    GeometryReader { geometryProxy in
      ZStack(alignment: .leading) {
        Rectangle()
          .foregroundColor(.yellow)
          .frame(width: (CGFloat(rating) / 5 * geometryProxy.size.width))
      }
    }
    .allowsHitTesting(false)
  }
  
  private var rowOfRatingsStars: some View {
    HStack {
      ForEach(1..<6) { index in
        Image(systemName: "star.fill")
          .font(.largeTitle)
          .foregroundColor(rating >= index ? .yellow : .gray)
          .onTapGesture {
            withAnimation(.easeInOut) {
              rating = index
            }
          }
      }
    }
  }
  
  private var naiveSolution: some View {
    ZStack {
      rowOfRatingsStars
    }
  }
}

struct Mask__Previews: PreviewProvider {
  static var previews: some View {
    Mask_()
  }
}
