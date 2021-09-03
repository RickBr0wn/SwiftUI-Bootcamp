//
//  NSCache_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 05/08/2021.
//

import SwiftUI

class NSCacheViewModel: ObservableObject {
  let imageName: String = "logo"
  
  @Published var startingImage: UIImage? = nil
  
  init() {
    getAssetsFromAssetsFolder()
  }
  
  func getAssetsFromAssetsFolder() {
    startingImage = UIImage(named: imageName)
  }
}

struct NSCache_: View {
  @StateObject private var vm = NSCacheViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        Image(vm.imageName)
          .resizable()
          .scaledToFill()
          .frame(width: 200, height: 200)
          .clipped()
          .cornerRadius(10.0)
        
        VStack {
          Button(action: {}, label: {
            Text("Save to Cache".uppercased())
              .font(.headline)
              .foregroundColor(.white)
              .padding()
              .frame(height: 55)
              .frame(maxWidth: .infinity)
              .background(Color.blue)
              .cornerRadius(10.0)
          })
          
          Button(action: {}, label: {
            Text("Delete from Cache".uppercased())
              .font(.headline)
              .foregroundColor(.white)
              .padding()
              .frame(height: 55)
              .frame(maxWidth: .infinity)
              .background(Color.red)
              .cornerRadius(10.0)
          })
        }
        .padding()
      }
    }
  }
}

struct NSCache__Previews: PreviewProvider {
  static var previews: some View {
    NSCache_()
  }
}
