//
//  UnitTestingViewModel_Tests.swift
//  SwiftUI-Bootcamp_Tests
//
//  Created by Rick Brown on 26/10/2021.
//

import XCTest
import Combine
@testable import SwiftUI_Bootcamp

/*
 Naming Structure - test_[struct or class]_[variable or function]_[expected result].
 Testing Structure - Given, When, Then.
 */
class UnitTestingViewModel_Tests: XCTestCase {
  var viewModel: UnitTestingViewModel?
  var cancellables = Set<AnyCancellable>()
  
  override func setUpWithError() throws {
    viewModel = UnitTestingViewModel(isPremium: Bool.random())
  }
  
  override func tearDownWithError() throws {
    viewModel = nil
  }
  
  func test_UnitTestingViewModel_isPremium_shouldBeTrue() {
    let userIsPremium: Bool = true
    let vm = UnitTestingViewModel(isPremium: userIsPremium)
    
    XCTAssertTrue(vm.isPremium)
  }
  
  func test_UnitTestingViewModel_isPremium_shouldBeFalse() {
    let userIsPremium: Bool = false
    let vm = UnitTestingViewModel(isPremium: userIsPremium)
    
    XCTAssertFalse(vm.isPremium)
  }
  
  func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue() {
    // this will run only once, and is susceptable to missing edge cases.
    let userIsPremium: Bool = Bool.random()
    let vm = UnitTestingViewModel(isPremium: userIsPremium)
    
    XCTAssertEqual(vm.isPremium, userIsPremium)
  }
  
  func test_UnitTestingViewModel_isPremium_shouldBeInjectedValueUnderStress() {
    // solve the above problem by running it several times
    for _ in 0..<100 {
      let userIsPremium = Bool.random()
      let vm = UnitTestingViewModel(isPremium: userIsPremium)
      
      XCTAssertEqual(vm.isPremium, userIsPremium)
    }
  }
  
  func test_UnitTestingViewModel_dataArray_shouldBeEmpty() {
    guard let vm = viewModel else { return }
    
    XCTAssertTrue(vm.dataArray.isEmpty)
    XCTAssertEqual(vm.dataArray.count, 0)
  }
  
  func test_UnitTestingViewModel_dataArray_shouldAddItems() {
    guard let vm = viewModel else { return }
    
    let loopCount: Int = Int.random(in: 1..<100)
    
    for _ in 0..<loopCount {
      vm.addItem(item: UUID().uuidString)
    }
    
    XCTAssertTrue(!vm.dataArray.isEmpty)
    XCTAssertFalse(vm.dataArray.isEmpty)
    XCTAssertEqual(vm.dataArray.count, loopCount)
    XCTAssertGreaterThan(vm.dataArray.count, 0)
  }
  
  func test_UnitTestingViewModel_dataArray_shouldNotAppendABlankString() {
    guard let vm = viewModel else { return }
    let testString: String = ""
    
    vm.addItem(item: testString)
    
    XCTAssertTrue(vm.dataArray.isEmpty)
    XCTAssertFalse(!vm.dataArray.isEmpty)
    XCTAssertEqual(vm.dataArray.count, 0)
    XCTAssertLessThan(vm.dataArray.count, 1)
    XCTAssertEqual(vm.dataArray.first, nil)
  }
  
  func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenSelectingAnInvalidItem() {
    guard let vm = viewModel else { return }
    // first select a valid item (which wil place it in selectedItem)
    let newItem = UUID().uuidString
    
    vm.addItem(item: newItem)
    vm.selectItem(item: newItem)
    // now use a invalid item (selectedItem is never cleared)
    vm.selectItem(item: UUID().uuidString)
    
    XCTAssertNil(vm.selectedItem)
  }
  
  func test_UnitTestingViewModel_selectedItem_shouldBeSelectedUnderStress() {
    guard let vm = viewModel else { return }
    let loopCount: Int = Int.random(in: 1..<100)
    var itemsArray: [String] = []
    
    for _ in 0..<loopCount {
      let newItem = UUID().uuidString
      
      vm.addItem(item: newItem)
      
      itemsArray.append(newItem)
    }
    
    let randomItem = itemsArray.randomElement() ?? ""
    
    vm.selectItem(item: randomItem)
    
    XCTAssertFalse(randomItem.isEmpty)
    XCTAssertNotNil(vm.selectedItem)
    XCTAssertEqual(vm.selectedItem, randomItem)
  }
  
  func test_UnitTestingViewModel_saveItem_shouldThrowError_itemNotFound() {
    guard let vm = viewModel else { return }
    
    let loopCount: Int = Int.random(in: 1..<100)
    
    for _ in 0..<loopCount {
      vm.addItem(item: UUID().uuidString)
    }
    
    XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
    XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Show throw `Item Not Found` error.") { error in
      let returnedError = error as? UnitTestingViewModel.DataError
      
      XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.itemNotFound)
    }
  }
  
  func test_UnitTestingViewModel_saveItem_shouldThrowError_noData() {
    guard let vm = viewModel else { return }
    
    let loopCount: Int = Int.random(in: 1..<100)
    
    for _ in 0..<loopCount {
      vm.addItem(item: UUID().uuidString)
    }
    
    do {
      try vm.saveItem(item: "")
    } catch let error {
      let returnedError = error as? UnitTestingViewModel.DataError
      
      XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.noData)
    }
  }
  
  func test_UnitTestingViewModel_saveItem_shouldSaveItemWithoutError() {
    guard let vm = viewModel else { return }
    
    let loopCount: Int = Int.random(in: 1..<100)
    var items: Array<String> = []
    
    for _ in 0..<loopCount {
      let item: String = UUID().uuidString
      vm.addItem(item: item)
      items.append(item)
    }
    
    let randomItem = items.randomElement() ?? ""
    
    XCTAssertFalse(randomItem.isEmpty)
    // XCTAssertNoThrow(try vm.saveItem(item: randomItem))
    do {
      try vm.saveItem(item: randomItem)
    } catch {
      XCTFail()
    }
  }
  
  func test_UnitTestingViewModel_downloadWithEscaping_shouldReturnItems() {
    guard let vm = viewModel else { return }
    
    let expectation = XCTestExpectation(description: "Should return items after three seconds.")
    
    vm.$dataArray
      .dropFirst()
      .sink { returnedItems in
        expectation.fulfill()
      }
      .store(in: &cancellables)
    
    vm.downloadWithEscaping()
    
    wait(for: [expectation], timeout: 5.0)
    XCTAssertGreaterThan(vm.dataArray.count, .zero)
  }
  
  func test_UnitTestingViewModel_downloadWithCombine_shouldReturnItems() {
    guard let vm = viewModel else { return }
    
    let expectation = XCTestExpectation(description: "Should return items after one second.")
    
    vm.$dataArray
      .dropFirst()
      .sink { returnedItems in
        expectation.fulfill()
      }
      .store(in: &cancellables)
    
    vm.downloadWithCombine()
    
    wait(for: [expectation], timeout: 2.0)
    XCTAssertGreaterThan(vm.dataArray.count, .zero)
  }
  
  func test_UnitTestingViewModel_downloadWithCombine_shouldReturnItems_DuplicatedWithNewMockDataService() {
    let items: Array<String> = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString,]
    let dataService: NewDataServiceProtocol = NewMockDataService(items: items)
    
    let vm = UnitTestingViewModel(isPremium: Bool.random(), dataService: dataService)
    
    let expectation = XCTestExpectation(description: "Should return items after one second.")
    
    vm.$dataArray
      .dropFirst()
      .sink { returnedItems in
        expectation.fulfill()
      }
      .store(in: &cancellables)
    
    vm.downloadWithCombine()
    
    wait(for: [expectation], timeout: 2.0)
    XCTAssertGreaterThan(vm.dataArray.count, .zero)
    XCTAssertEqual(vm.dataArray.count, items.count)
  }
}
