//
//  UnitTestingViewModel.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 26/10/2021.
//

import SwiftUI
import Combine

class UnitTestingViewModel: ObservableObject {
  @Published var isPremium: Bool
  @Published var dataArray: [String] = []
  @Published var selectedItem: String? = nil
  
  var cancellables = Set<AnyCancellable>()
  
  let dataService: NewDataServiceProtocol
  
  func addItem(item: String) {
    guard !item.isEmpty else { return }
    
    self.dataArray.append(item)
  }
  ///  The default value given to dataService, is to avoid errors on the previous test written.
  ///  And as a result it is not normally required
  init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
    self.isPremium = isPremium
    self.dataService = dataService
  }
  
  func selectItem(item: String) {
    if let x = dataArray.first(where: { $0 == item }) {
      selectedItem = x
    } else {
      selectedItem = nil
    }
  }
  
  func saveItem(item: String) throws {
    guard !item.isEmpty else { throw DataError.noData }
    
    if let x = dataArray.first(where: { $0 == item }) {
      print("save item here!!! \(x)")
    } else {
      throw DataError.itemNotFound
    }
  }
  
  enum DataError: LocalizedError {
    case noData, itemNotFound
  }
  
  func downloadWithEscaping() {
    dataService.downloadItemsWithEscaping { [weak self] items in
      self?.dataArray = items
    }
  }
  
  func downloadWithCombine() {
    dataService.downloadItemsWithCombine()
      .sink { _ in
       /// Completion and Error can be found in the unsed parameter here.
      } receiveValue: { [weak self] returnedItems in
        self?.dataArray = returnedItems
      }
      .store(in: &cancellables)
  }
}
