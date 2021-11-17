//
//  UIViewControllerRepresentable_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 17/11/2021.
//

import SwiftUI

struct UIViewControllerRepresentable_: View {
  @State private var showScreen: Bool = false
  @State private var image: UIImage? = nil
  
  var body: some View {
    VStack {
      if let image = image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      }
      Button(action: { self.showScreen.toggle() }) {
        Text("Click me!")
      }
      .sheet(isPresented: $showScreen) {
        UIImagePickerControllerRepresentable(image: $image)
      }
    }
  }
}

struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
  let labelText: String
  
  func makeUIViewController(context: Context) -> some UIViewController {
    let vc = MyFirstViewController()
    vc.labelText = labelText
    return vc
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

class MyFirstViewController: UIViewController {
  var labelText: String = "starting value!"
  
  override func viewDidLoad() {
    let label  = UILabel()
    
    label.text = labelText
    label.textColor = .white
    label.textAlignment = .center
    label.frame = view.frame
    
    view.backgroundColor = .blue
    view.addSubview(label)
  }
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
  @Binding var image: UIImage?
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let vc = UIImagePickerController()
    vc.allowsEditing = false
    vc.delegate = context.coordinator
    return vc
  }
  /// SwiftUI -> UIKit
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    
  }
  /// UIKit -> SwiftUI
  func makeCoordinator() -> Coordinator {
    Coordinator(image: $image)
  }
  
  class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @Binding var image: UIImage?
    
    init(image: Binding<UIImage?>) {
      self._image = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      guard let newImage = info[.originalImage] as? UIImage else { return }
      image = newImage
      picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true)
    }
  }
}

struct UIViewControllerRepresentable_Previews: PreviewProvider {
  static var previews: some View {
    UIViewControllerRepresentable_()
  }
}
