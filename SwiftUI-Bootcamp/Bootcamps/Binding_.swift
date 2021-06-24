//
//  Binding_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 24/06/2021.
//

import SwiftUI

struct Binding_: View {
  @State var backgroundColor: Color = Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
  
  var body: some View {
    ZStack {
      Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)).edgesIgnoringSafeArea(.all)
      
      ButtonComponent(backgroundColor: $backgroundColor)
    }
  }
}

struct ButtonComponent: View {
  @Binding var backgroundColor: Color
  
  var body: some View {
    Button(action: {
      backgroundColor = Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))
    }, label: {
      Text("Button")
        .foregroundColor(.white)
        .padding()
        .padding(.horizontal)
        .background(backgroundColor.cornerRadius(20.0))
    })
  }
}

struct Binding__Previews: PreviewProvider {
  static var previews: some View {
    Binding_()
  }
}
