//
//  Protocols_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 17/11/2021.
//

import SwiftUI

struct defaultColorTheme: ColorTheme {
  let primary: Color = .blue
  let secondary: Color = .white
  let tertiary: Color = .gray
}

struct alternativeColorTheme: ColorTheme {
  let primary: Color = .red
  let secondary: Color = .white
  let tertiary: Color = .green
}

struct newColorTheme: ColorTheme {
  let primary: Color = .blue
  let secondary: Color = .white
  let tertiary: Color = .purple
}

protocol ColorTheme {
  var primary: Color { get }
  var secondary: Color { get }
  var tertiary: Color { get }
}

protocol ButtonTextProtocol {
  var buttonText: String { get }
}

protocol ButtonPressedProtocol {
  func buttonPressed()
}

protocol ButtonDataSourceProtocol: ButtonTextProtocol, ButtonPressedProtocol {}

class DefaultDataSource: ButtonDataSourceProtocol {
  var buttonText: String = "Protocols are awesome!!"
  
  func buttonPressed() {
    print("Button was pressed!")
  }
}

class AlternativeDataSource: ButtonTextProtocol {
  var buttonText: String = "Protocols are lame!!"
}

struct Protocols_: View {
  let colorTheme: ColorTheme
  let defaultDataSource: ButtonDataSourceProtocol
  
  var body: some View {
    ZStack {
      colorTheme.tertiary.edgesIgnoringSafeArea(.all)
      
      Text(defaultDataSource.buttonText)
        .font(.headline)
        .foregroundColor(colorTheme.secondary)
        .padding()
        .background(colorTheme.primary)
        .cornerRadius(10.0)
        .onTapGesture { defaultDataSource.buttonPressed() }
    }
  }
}

struct Protocols__Previews: PreviewProvider {
  static var previews: some View {
    Protocols_(colorTheme: newColorTheme(), defaultDataSource: DefaultDataSource())
  }
}
