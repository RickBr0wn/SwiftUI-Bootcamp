//
//  AppNavBarView.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 15/11/2021.
//

import SwiftUI

struct AppNavBarView: View {
  var body: some View {
    CustomNavView {
      ZStack {
        Color.green
        CustomNavLink {
          Text("Destination ☺️")
            .customNavBarItems(title: "dummy!", subtitle: "a fish!", hidesBackButton: false
            )
        } label: {
          Text("GO!")
        }
      }
      .customNavigationTitle("This is the title!!")
      .customNavigationSubTitle("A subtitle is worth a million things!")
      .customNavigationBackButtonHidden(true)
    }
  }
}

extension AppNavBarView {
  private var defaultNavBarView: some View {
    NavigationView {
      ZStack {
        Color.green.edgesIgnoringSafeArea(.all)
        
        NavigationLink("Go to the grey screen!") {
          Color.gray
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Title #2")
          // .navigationBarBackButtonHidden(true)
        }
      }
      .navigationTitle("nav title here")
    }
  }
}

struct AppNavBarView_Previews: PreviewProvider {
  static var previews: some View {
    AppNavBarView()
  }
}

