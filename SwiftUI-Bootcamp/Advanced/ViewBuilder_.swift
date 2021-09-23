//
//  ViewBuilder_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 23/09/2021.
//

import SwiftUI

struct headerViewRegular: View {
  let title: String
  let description: String?
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.largeTitle)
        .fontWeight(.semibold)
      if let description = description {
        Text(description)
          .font(.callout)
      }
      RoundedRectangle(cornerRadius: 5.0)
        .frame(height: 2)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding()
  }
}

struct headerViewGeneric<T: View>: View {
  var title: String
  var content: T
  
  init(title: String, @ViewBuilder content: () -> T) {
    self.title = title
    self.content = content()
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.largeTitle)
        .fontWeight(.semibold)
      
      content
      
      RoundedRectangle(cornerRadius: 5.0)
        .frame(height: 2)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding()
  }
}

struct customHStack<T: View>: View {
  let content: T
  
  init(@ViewBuilder content: () -> T) {
    self.content = content()
  }
  
  var body: some View {
    HStack {
      content
    }
  }
}

struct LocalViewBuilder: View {
  
  enum ViewType { case one, two, three }
  
  let type: ViewType
  
  var body: some View {
    VStack {
      headerSection
    }
  }
  
  @ViewBuilder private var headerSection: some View {
    switch type {
    case .one:
      viewOne
    case .two:
      viewTwo
    case .three:
      viewThree
    }
  }
  
  private var viewOne: some View {
    Text("One")
  }
  
  private var viewTwo: some View {
    VStack {
      Text("One")
      Text("Two")
    }
  }
  
  private var viewThree: some View {
    VStack {
      Text("One")
      Text("Two")
      Text("Three")
    }
  }
}

struct ViewBuilder_: View {
  var body: some View {
    VStack {
      headerViewRegular(title: "dev.title", description: "dev.description")
      
      headerViewRegular(title: "dev.title", description: nil)
      
      headerViewGeneric(title: "dev.title") { Image(systemName: "info.circle.fill") }
      
      headerViewGeneric(title: "dev.title") { Text("Content") }
      
      Spacer()
      
      customHStack {
        Text("HI")
        Text("HI")
        Text("HI")
      }
    }
  }
}

struct ViewBuilder__Previews: PreviewProvider {
  static var previews: some View {
    LocalViewBuilder(type: .three)
  }
}
