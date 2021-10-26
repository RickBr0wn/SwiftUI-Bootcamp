//
//  DependencyInjection_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 22/10/2021.
//

import SwiftUI
import Combine

/*
 {
 "userId": 1,
 "id": 1,
 "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
 "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
 },
 */

// Discussion:
/*
 Problems with the singleton pattern:
 
 - Singletons are GLOBAL
 - Cannot customize the init()
 - Cannot swap out dependencies
 
 */

struct PostsModel: Codable, Identifiable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}

protocol DataServiceProtocol {
  func getData() -> AnyPublisher<[PostModel], Error>
}

class ProductionDataService: DataServiceProtocol {
  // static let instance = ProductionDataService()
  
  let url: URL
  
  init(url: URL) {
    self.url = url
  }
  
  func getData() -> AnyPublisher<[PostModel], Error> {
    URLSession.shared.dataTaskPublisher(for: url)
      .map({ $0.data })
      .decode(type: [PostModel].self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}

class MockDataService: DataServiceProtocol {
  let testData: [PostModel]
  
  init(data: [PostModel]?) {
    self.testData = data ?? [
      PostModel(id: 1, userId: 1, title: "One", body: "One"),
      PostModel(id: 2, userId: 2, title: "Two", body: "Two")
    ]
  }
  
  func getData() -> AnyPublisher<[PostModel], Error> {
    Just(testData)
      .tryMap({ $0 })
      .eraseToAnyPublisher()
  }
}

class DependencyInjection_ViewModel: ObservableObject {
  @Published var dataArray: [PostModel] = []
  
  var cancellables = Set<AnyCancellable>()
  
  let dataService: DataServiceProtocol
  
  init(dataService: DataServiceProtocol) {
    self.dataService = dataService
    loadPosts()
  }
  
  private func loadPosts() {
    dataService.getData()
      .sink { _ in
        
      } receiveValue: { [weak self] returnedPosts in
        self?.dataArray = returnedPosts
      }
      .store(in: &cancellables)
  }
}

struct DependencyInjection_: View {
  @StateObject private var vm: DependencyInjection_ViewModel
  
  init(dataService: DataServiceProtocol) {
    _vm = StateObject(wrappedValue: DependencyInjection_ViewModel(dataService: dataService))
  }
  
  var body: some View {
    ScrollView {
      VStack {
        ForEach(vm.dataArray) { post in
          Text(post.title)
        }
      }
    }
  }
}

struct DependencyInjection__Previews: PreviewProvider {
  //  static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
  static let dataService = MockDataService(data: nil)
  
  static var previews: some View {
    DependencyInjection_(dataService: dataService)
  }
}
