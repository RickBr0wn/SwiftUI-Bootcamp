//
//  NewMockDataService.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 19/11/2021.
//

import Foundation
import SwiftUI
import Combine

protocol NewDataServiceProtocol {
  func downloadItemsWithEscaping(completion: @escaping (_ items: Array<String>) -> ())
  
  func downloadItemsWithCombine() -> AnyPublisher<Array<String>, Error>
}

class NewMockDataService: NewDataServiceProtocol {
  var items: Array<String> = []
  
  init(items: Array<String>?) {
    self.items = items ?? ["ONE", "TWO", "THREE"]
  }
  
  func downloadItemsWithEscaping(completion: @escaping (_ items: Array<String>) -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      completion(self.items)
    }
  }
  
  func downloadItemsWithCombine() -> AnyPublisher<Array<String>, Error> {
    Just(items)
      .tryMap({ publishedItems in
        guard !publishedItems.isEmpty else {
          throw URLError(.badServerResponse)
        }
        return publishedItems
      })
      .eraseToAnyPublisher()
  }
}


