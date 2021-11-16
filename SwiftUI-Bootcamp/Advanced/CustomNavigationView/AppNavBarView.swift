//
//  AppNavBarView.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 15/11/2021.
//

import SwiftUI

struct AppNavBarView: View {
  var body: some View {
    NavigationView {
      ZStack {
        Color.red.edgesIgnoringSafeArea(.all)
        
        NavigationLink("Blue") {
          Color.green.edgesIgnoringSafeArea(.all)
        }
      }
    }
  }
}

struct AppNavBarView_Previews: PreviewProvider {
  static var previews: some View {
    AppNavBarView()
  }
}
