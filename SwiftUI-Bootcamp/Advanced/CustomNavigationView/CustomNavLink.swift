//
//  CustomNavLink.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 16/11/2021.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
  let destination: Destination
  let label: Label
  /// Creates a navigation link that presents the destination view.
  /// - Parameters:
  ///   - destination: A view for the navigation link to present.
  ///   - label: A view builder to produce a label describing the `destination`
  ///    to present.
  public init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
    self.destination = destination()
    self.label = label()
  }
  /// Creates a navigation link that presents the destination view.
  /// - Parameters:
  ///   - destination: A view for the navigation link to present.
  ///   - label: A view builder to produce a label describing the `destination`
  ///    to present.
  public init(destination: Destination, @ViewBuilder label: () -> Label) {
    self.destination = destination
    self.label = label()
  }
  
  var body: some View {
    NavigationLink(destination:
                    CustomNavBarContainerView(content: {
      destination
    })
                    .navigationBarHidden(true)
    ) {
      label
    }
  }
}

struct CustomNavLink_Previews: PreviewProvider {
  static var previews: some View {
    CustomNavView {
      CustomNavLink {
        Text("Destination")
      } label: {
        Text("Navigate!")
      }
    }
  }
}
