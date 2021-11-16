//
//  UnitTestingViewModel.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 26/10/2021.
//

import SwiftUI

class UnitTestingViewModel: ObservableObject {
  @Published var isPremium: Bool
  @Published var dataArray: [String] = []
  @Published var selectedItem: String? = nil
  
  func addItem(item: String) {
    guard !item.isEmpty else { return }
    
    self.dataArray.append(item)
  }
  
  init(isPremium: Bool) {
    self.isPremium = isPremium
  }
  
  func selectItem(item: String) {
    if let x = dataArray.first(where: { $0 == item }) {
      selectedItem = x
    } else {
      selectedItem = nil
    }
  }
  
  func saveItems(item: String) throws {
    guard !item.isEmpty else { throw DataError.noData }
    
    if let x = dataArray.first(where: { $0 == item }) {
      print("save item here!!! \(x)")
    } else {
      throw DataError.itemNotFound
    }
    
    enum DataError: LocalizedError {
      case noData, itemNotFound
    }
  }
}
