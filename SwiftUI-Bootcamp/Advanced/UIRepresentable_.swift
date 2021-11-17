//
//  UIRepresentable_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 16/11/2021.
//

import SwiftUI

struct UIRepresentable_: View {
  @State private var text: String = ""
  
  var body: some View {
    VStack {
      Text(text)
        .font(.title)
      
      Divider()
      
      VStack {
        Text("SwifUI")
        TextField("type here...", text: $text)
          .frame(height: 55)
          .background(Color.gray)
      }
      Divider()
      VStack {
        Text("UIKit")
        UIKitTextFieldViewRepresentable(text: $text)
          .updatePlaceholder("MY NEW PLACEHOLDER!!!!!")
          .frame(height: 55)
          .background(Color.gray)
      }
    }
  }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> some UIView {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct UIKitTextFieldViewRepresentable: UIViewRepresentable {
  @Binding var text: String
  var placeholder: String
  let placeholderColor: UIColor
  
  init(text: Binding<String>, placeholder: String = "type here..", placeholderColor: UIColor = .green) {
    self._text = text
    self.placeholder = placeholder
    self.placeholderColor = placeholderColor
  }
  
  func makeUIView(context: Context) -> UITextField {
    let textfield = getTextField()
    textfield.delegate = context.coordinator
    return textfield
  }
  /// from SwiftUI to UIKit
  func updateUIView(_ uiView: UITextField, context: Context) {
    uiView.text = text
  }
  /// from UIKit to SwiftUI
  func makeCoordinator() -> Coordinator {
    Coordinator(text: $text)
  }
  
  class Coordinator: NSObject, UITextFieldDelegate {
    @Binding var text: String
    
    init(text: Binding<String>) {
      self._text = text
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
      text = textField.text ?? ""
    }
  }
  
  private func getTextField() -> UITextField {
    let textfield = UITextField(frame: .zero)
    let placeholder = NSAttributedString(
      string: placeholder,
      attributes: [.foregroundColor : placeholderColor]
    )
    textfield.attributedPlaceholder = placeholder
    return textfield
  }
  
  func updatePlaceholder(_ text: String) -> UIKitTextFieldViewRepresentable {
    var viewRepresentable = self
    viewRepresentable.placeholder = text
    return viewRepresentable
  }
}

struct UIRepresentable__Previews: PreviewProvider {
  static var previews: some View {
    UIRepresentable_()
  }
}
