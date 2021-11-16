//
//  CustomNavBarView.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 16/11/2021.
//

import SwiftUI

struct CustomNavBarView: View {
  @Environment(\.presentationMode) var presentationMode
  let showBackButton: Bool
  let title: String
  let subtitle: String?
  
  var body: some View {
    HStack {
      if showBackButton { backButton }
      Spacer()
      titleSection
      Spacer()
      if showBackButton { backButton.opacity(0.0) }
    }
    .padding()
    .font(.headline)
    .background(Color.blue.edgesIgnoringSafeArea(.top))
    .accentColor(.white)
    .foregroundColor(.white)
  }
}

extension CustomNavBarView {
  private var backButton: some View {
    Button(action: {
      presentationMode.wrappedValue.dismiss()
    }) {
      Image(systemName: "chevron.left")
    }
  }
  
  private var titleSection: some View {
    VStack(spacing: 4) {
      Text(title)
        .font(.title)
        .fontWeight(.semibold)
      
      if let subtitle = subtitle {
        Text(subtitle)
      }
    }
  }
}

struct CustomNavBarView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      CustomNavBarView(showBackButton: false, title: "title", subtitle: "subtitle")
      Spacer()
    }
  }
}
