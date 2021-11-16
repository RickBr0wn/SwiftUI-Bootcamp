//
//  UnitTestingViewModel_Tests.swift
//  SwiftUI-Bootcamp_Tests
//
//  Created by Rick Brown on 26/10/2021.
//

import XCTest
@testable import SwiftUI_Bootcamp

/*
 Naming Structure - test_[struct or class]_[variable or function]_[expected result].
 Testing Structure - Given, When, Then.
 */
class UnitTestingViewModel_Tests: XCTestCase {
  
  override func setUpWithError() throws {}
  
  override func tearDownWithError() throws {}
  
  func test_UnitTestingViewModel_isPremium_shouldBeTrue() {
    let userIsPremium = true
    let vm = UnitTestingViewModel(isPremium: userIsPremium)
    XCTAssertTrue(vm.isPremium)
  }
  
  func test_UnitTestingViewModel_isPremium_shouldBeFalse() {
    let userIsPremium = false
    let vm = UnitTestingViewModel(isPremium: userIsPremium)
    XCTAssertFalse(vm.isPremium)
  }
  
  func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue() {
    // this will run only once, and is susceptable to missing edge cases.
    let userIsPremium = Bool.random()
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
    let vm = UnitTestingViewModel(isPremium: Bool.random())
    XCTAssertTrue(vm.dataArray.isEmpty)
    XCTAssertEqual(vm.dataArray.count, 0)
  }
  
  func test_UnitTestingViewModel_dataArray_shouldAddItems() {
    let vm = UnitTestingViewModel(isPremium: Bool.random())
    
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
    let vm = UnitTestingViewModel(isPremium: Bool.random())
    let testString: String = ""
    vm.addItem(item: testString)
    XCTAssertTrue(vm.dataArray.isEmpty)
    XCTAssertFalse(!vm.dataArray.isEmpty)
    XCTAssertEqual(vm.dataArray.count, 0)
    XCTAssertLessThan(vm.dataArray.count, 1)
    XCTAssertEqual(vm.dataArray.first, nil)
  }
  
  func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenSelectingAnInvalidItem() {
    let vm = UnitTestingViewModel(isPremium: Bool.random())
    // first select a valid item (which wil place it in selectedItem)
    let newItem = UUID().uuidString
    vm.addItem(item: newItem)
    vm.selectItem(item: newItem)
    // now use a invalid item (selectedItem is never cleared)
    vm.selectItem(item: UUID().uuidString)
    XCTAssertNil(vm.selectedItem)
  }
  
  func test_UnitTestingViewModel_selectedItem_shouldBeSelectedUnderStress() {
    let vm = UnitTestingViewModel(isPremium: Bool.random())
    let loopCount: Int = Int.random(in: 1..<100)
    var itemsArray: [String] = []
    for _ in 0..<loopCount {
      let newItem = UUID().uuidString
      vm.addItem(item: newItem)
      itemsArray.append(newItem)
    }
    let randomItem = itemsArray.randomElement() ?? ""
    vm.selectItem(item: randomItem)
    XCTAssertNotNil(vm.selectedItem)
    XCTAssertEqual(vm.selectedItem, randomItem)
  }
  
//  func test_UnitTestingViewModel
}
