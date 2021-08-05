//
//  FileManager_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 05/08/2021.
//

import SwiftUI

class LocalFileManager {
  static let instance = LocalFileManager()
  
  private let folderName: String = "Example_Folder_Name"
  
  init() {
    createFolderIfNeededInFileManager()
  }
  
  func createFolderIfNeededInFileManager() {
    guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path  else { return }
    
    if !FileManager.default.fileExists(atPath: path) {
      do {
        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        print("success creating folder")
      } catch let error {
        print("Error creating folder: \(error)")
      }
    }
  }
  
  func deleteFolderFromFileManager() {
    guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path  else { return }
    
    do {
      try FileManager.default.removeItem(atPath: path)
      print("Successfully deleted folder: \(path)")
    } catch let error {
      print("Error deleteing folder: \(error)")
    }
  }
  
  func saveImage(image: UIImage, name: String) -> String {
    guard let data = image.pngData(),
          let path = getPathForImage(name: name) else {
      return "Error getting the data from image named: \(name)"
    }
    
    // let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    // let thirdDirectory = FileManager.default.temporaryDirectory
    // let path = directory?.appendingPathComponent("\(name).png")
    // print(directory)
    // print(path)
    
    do {
      try data.write(to: path)
      return "Successfully saved image to \(path)"
    } catch let error {
      return "Error saving image. \(error)"
    }
  }
  
  func getImage(name: String) -> UIImage? {
    guard let path = getPathForImage(name: name)?.path,
          FileManager.default.fileExists(atPath: path) else {
      print("Error getting path!")
      return nil
    }
    
    return UIImage(contentsOfFile: path)
  }
  
  func getPathForImage(name: String) -> URL? {
    guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .appendingPathComponent("\(name).png") else {
      print("Error generating path to save image to!")
      return nil
    }
    return path
  }
  
  func deleteImageFromFileManager(name: String) -> String {
    guard let path = getPathForImage(name: name),
          FileManager.default.fileExists(atPath: path.path) else {
      return "Error getting path!"
    }
    do {
      try FileManager.default.removeItem(at: path)
      return "successfully deleted"
    } catch let error {
      return "Error deleting image: \(error)"
    }
  }
}

class FileManagerViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  @Published var infoMessage: String = ""
  private let imageName: String = "logo"
  
  let manager = LocalFileManager.instance
  
  init() {
    getImageFromAssetsFolder()
    // getImageFromFileManager()
  }
  
  func getImageFromAssetsFolder() {
    image = UIImage(named: imageName)
  }
  
  func saveImageToFileManager() {
    guard let image = image else { return }
    infoMessage = manager.saveImage(image: image, name: imageName)
  }
  
  func getImageFromFileManager() {
    image = manager.getImage(name: imageName)
  }
  
  func deleteImageFromFileManager() {
    infoMessage = manager.deleteImageFromFileManager(name: imageName)
    manager.deleteFolderFromFileManager()
  }
}

struct FileManager_: View {
  @StateObject private var vm = FileManagerViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        if let image = vm.image {
          Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipped()
            .cornerRadius(10.0)
        }
        
        Text("OK")
        
        
        HStack {
          Button(action: {
            vm.saveImageToFileManager()
          }, label: {
            Text("Save to file manager".uppercased())
              .foregroundColor(.white)
              .padding()
              .padding(.horizontal)
              .background(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
              .cornerRadius(10.0)
        })
          
          Button(action: {
            vm.deleteImageFromFileManager()
          }, label: {
            Text("Delete from file manager".uppercased())
              .foregroundColor(.white)
              .padding()
              .padding(.horizontal)
              .background(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
              .cornerRadius(10.0)
          })
        }
        
        Text(vm.infoMessage)
          .font(.largeTitle)
          .fontWeight(.semibold)
          .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
        
        Spacer()
      }
      .navigationTitle("File Manager")
    }
  }
}

struct FileManager__Previews: PreviewProvider {
  static var previews: some View {
    FileManager_()
  }
}
