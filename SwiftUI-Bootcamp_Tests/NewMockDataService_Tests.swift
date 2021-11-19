//
//  NewMockDataService_Tests.swift
//  SwiftUI-Bootcamp_Tests
//
//  Created by Rick Brown on 19/11/2021.
//

import XCTest
import Combine
@testable import SwiftUI_Bootcamp

class NewMockDataService_Tests: XCTestCase {
  var cancellables = Set<AnyCancellable>()
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    cancellables.removeAll()
  }
  
  func test_NewMockDataService_init_setValuesCorrectly() {
    let items: Array<String>? = nil
    let differentItems: Array<String>? = []
    let evenMoreItems: Array<String>? = [UUID().uuidString, UUID().uuidString]
    
    let dataService = NewMockDataService(items: items)
    let differentDataService = NewMockDataService(items: differentItems)
    let evenMoreDataService = NewMockDataService(items: evenMoreItems)
    
    XCTAssertTrue(!dataService.items.isEmpty)
    XCTAssertTrue(differentDataService.items.isEmpty)
    XCTAssertEqual(evenMoreDataService.items.count, evenMoreItems?.count)
  }
  
  func test_NewMockDataService_downloadItemsWithEscaping_DoesReturnValues() {
    let dataService = NewMockDataService(items: nil)
    
    var items: Array<String> = []
    let expectation = XCTestExpectation()
    
    dataService.downloadItemsWithEscaping { returnedItems in
      items = returnedItems
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 5.0)
    XCTAssertEqual(items.count, dataService.items.count)
  }
  
  func test_NewMockDataService_downloadItemsWithCombine_DoesReturnValues() {
    let dataService = NewMockDataService(items: nil)
    
    var items: Array<String> = []
    let expectation = XCTestExpectation()
    
    dataService.downloadItemsWithCombine()
      .sink { completion in
        switch completion {
        case .finished:
          expectation.fulfill()
        case .failure:
          XCTFail()
        }
      } receiveValue: { returnedItems in
        items = returnedItems
      }
      .store(in: &cancellables)
    
    wait(for: [expectation], timeout: 5.0)
    XCTAssertEqual(items.count, dataService.items.count)
  }
  
  func test_NewMockDataService_downloadItemsWithCombine_BlankArrayDoesThrowError() {
    let dataService = NewMockDataService(items: [])
    
    var items: Array<String> = []
    let errorExpectation = XCTestExpectation(description: "Does throw an error")
    let urlErrorExpectation = XCTestExpectation(description: "Does throw URLError.badServerResponse")
    
    dataService.downloadItemsWithCombine()
      .sink { completion in
        switch completion {
        case .finished:
          XCTFail()
        case .failure(let error):
          errorExpectation.fulfill()
          
          // let urlError = error as? URLError
          // XCTAssertEqual(urlError, URLError(.badServerResponse))
          
          if error as? URLError == URLError(.badServerResponse) {
            urlErrorExpectation.fulfill()
          }
        }
      } receiveValue: { returnedItems in
        items = returnedItems
      }
      .store(in: &cancellables)
    
    wait(for: [errorExpectation, urlErrorExpectation], timeout: 5.0)
    XCTAssertEqual(items.count, dataService.items.count)
  }
}
