//
//  DownloadJSONDataFromInternet.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 03/08/2021.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
  let id: Int
  let userId: Int
  let title: String
  let body: String
}

class DownloadJSONDataFromInternetViewModel: ObservableObject {
  @Published var posts: Array<PostModel> = Array()
  
  init() {
    getPosts()
  }
  
  func getPosts() {
    print("get posts")
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
    
    downloadData(fromURL: url) { returnedData in
      print("inner closure")
      if let data = returnedData {
        guard let newPosts = try? JSONDecoder().decode(Array<PostModel>.self, from: data) else { return }
        print("about to dispatchQueue")
        DispatchQueue.main.async { [weak self] in
          self?.posts = newPosts
        }
      } else {
        print("No data returned!")
      }
    }
  }
  
  func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> (Void)) {
    print("downloadData called")
    URLSession.shared.dataTask(with: url) { data, response, error in
      print("urlsession")
      guard let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
        print("Error occured during the downloading of the data.")
        completionHandler(nil)
        return
      }
      print("completed!")
      completionHandler(data)
    }
  }
}

struct DownloadJSONDataFromInternet: View {
  @StateObject private var vm = DownloadJSONDataFromInternetViewModel()
  
  var body: some View {
    List {
      ForEach(vm.posts) { post in
        VStack(alignment: .leading) {
          Text(post.title)
            .font(.headline)
          Text(post.body)
            .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}

struct DownloadJSONDataFromInternet_Previews: PreviewProvider {
  static var previews: some View {
    DownloadJSONDataFromInternet()
  }
}
