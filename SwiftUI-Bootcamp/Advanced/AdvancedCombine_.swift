//
//  AdvancedCombine_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 20/11/2021.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    @Published var basicPublisher: String = "first publish"
  var currentValuePublisher = CurrentValueSubject<String, Never>("First publish!")
  
  init() {
    publishFakeData()
  }
  
  private func publishFakeData() {
    let items = ["one", "two", "three"]
    
    for index in items.indices {
      DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) + 1.0) {
        self.basicPublisher = items[index]
      }
    }
  }
}

class AdvancedCombineViewModel: ObservableObject {
  @Published var data: Array<String> = []
  let dataService = AdvancedCombineDataService()
  
  var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  private func addSubscribers() {
    dataService.$basicPublisher
      .sink { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          print("Error: \(error.localizedDescription)")
        }
      } receiveValue: { [weak self] returnedString in
        guard let self = self else { return }
        self.data.append(returnedString)
      }
      .store(in: &cancellables)
    
  }
}

struct AdvancedCombine_: View {
  @StateObject private var vm = AdvancedCombineViewModel()
  
  var body: some View {
    ScrollView {
      VStack {
        ForEach(vm.data, id: \.self) {
          Text($0)
            .font(.largeTitle)
            .fontWeight(.black)
        }
      }
    }
  }
}

struct AdvancedCombine__Previews: PreviewProvider {
  static var previews: some View {
    AdvancedCombine_()
  }
}
