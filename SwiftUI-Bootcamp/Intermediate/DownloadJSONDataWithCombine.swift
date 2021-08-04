//
//  DownloadJSONDataWithCombine.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 04/08/2021.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
  let id: Int
  let userId: Int
  let title: String
  let body: String
}

class DownloadJSONDataWithCombineViewModel: ObservableObject {
  @Published var posts: Array<PostModel> = Array()
  var cancellables = Set<AnyCancellable>()
  
  init() {
    getPosts()
  }
  
  func getPosts() {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
    
    // create a publisher
    URLSession.shared.dataTaskPublisher(for: url)
      // subcscribe the publisher on a background thread, not needed: URLSession.shared.dataTaskPublisher does this behind the scenes
      .subscribe(on: DispatchQueue.global(qos: .background))
      // recieve on the main thread
      .receive(on: DispatchQueue.main)
      // tryMap (checking that the data is good
      .tryMap(handleOutput)
      // decode the data in Array<PostModel>
      .decode(type: Array<PostModel>.self, decoder: JSONDecoder())
      // sink
      .sink { completion in
        // the parameter (completion) is of type: Subscribers.Completion<Error>
        switch completion {
        case .finished:
          print("finished")
        case .failure(let error):
          // maybe use an alert?
          print("Error: \(error.localizedDescription)")
        }
      } receiveValue: { [weak self] returnedPosts in
        self?.posts = returnedPosts
      }
      // store - cancel the subscription
      .store(in: &cancellables)
  }
  
  func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
    guard let response = output.response as? HTTPURLResponse,
          response.statusCode >= 200 && response.statusCode < 300 else {
      throw URLError(.badServerResponse)
    }
    return output.data
  }
}

struct DownloadJSONDataWithCombine: View {
  @StateObject private var vm = DownloadJSONDataWithCombineViewModel()
  
  var body: some View {
    List {
      ForEach(vm.posts) { post in
        VStack(alignment: .leading) {
          Text(post.title)
            .font(.headline)
          Text(post.body)
            .foregroundColor(.gray)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct DownloadJSONDataWithCombine_Previews: PreviewProvider {
  static var previews: some View {
    DownloadJSONDataWithCombine()
  }
}

