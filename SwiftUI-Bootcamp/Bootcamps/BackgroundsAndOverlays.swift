//
//  BackgroundsAndOverlays.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 24/06/2021.
//

import SwiftUI

struct BackgroundsAndOverlays: View {
//  var body: some View {
//    Text("Hello, World!")
//      .background(
//        //            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing),
//        Circle()
//          .fill(
//            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
//          )
//          .frame(width: 200, height: 200),
//        alignment: .center
//      )
//      .background(
//        Circle()
//          .fill(
//            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .trailing, endPoint: .leading)
//          )
//          .frame(width: 240, height: 240),
//        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//  }
  var body: some View {
    Circle()
      .fill(Color.pink)
      .frame(width: 100, height: 100, alignment: .center)
      .overlay(
        Text("1")
          .font(.largeTitle)
          .foregroundColor(.white)
      )
      .frame(width: 150, height: 150, alignment: .center)
      .background(Color.purple)
  }
}

struct BackgroundsAndOverlays_Previews: PreviewProvider {
  static var previews: some View {
    BackgroundsAndOverlays()
  }
}
