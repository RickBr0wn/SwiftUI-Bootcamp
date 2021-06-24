//
//  Initializer_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 24/06/2021.
//

import SwiftUI

struct Initializer_: View {
  let backgroundColor: Color
  let count: Int
  let title: String
  
  enum Fruit {
    case apple, orange
  }
  
  init(count: Int, fruit: Fruit) {
    self.count = count
    
    switch fruit {
    case .apple:
      self.title = "Apple"
      self.backgroundColor = .green
    case .orange:
      self.title = "Orange"
      self.backgroundColor = .orange
    }
  }
  
  var body: some View {
    VStack(spacing: 12) {
      Text("\(count)")
        .font(.largeTitle)
        .foregroundColor(.white)
        .underline()
      
      Text(title)
        .font(.headline)
        .foregroundColor(.white)
    }
    .frame(width: 150, height: 150, alignment: .center)
    .background(backgroundColor)
    .cornerRadius(10.0)
  }
}

struct Initializer__Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      Initializer_(count: 4, fruit: .apple)
      Initializer_(count: 7, fruit: .orange)
    }
  }
}
