//
//  CustomerPublishersAndSubscribers.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 04/08/2021.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
  @Published var count : Int = 0
  @Published var textFieldText: String = ""
  @Published var textIsValid: Bool = false
  
  @Published var showButton: Bool = false
  
  var cancellables = Set<AnyCancellable>()
  
  init() {
    setUpTimer()
    addTextFieldSubscriber()
    addButtonSubscriber()
  }
  
  func addTextFieldSubscriber() {
    $textFieldText
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map { text -> Bool in
        if text.count > 3 { return true }
        return false
      }
      // .assign(to: \.textIsValid, on: self)
      .sink(receiveValue: { [weak self] isValid in
        self?.textIsValid = isValid
      })
      .store(in: &cancellables)
  }
  
  func setUpTimer() {
    Timer.publish(every: 1.0, on: .main, in: .common)
      .autoconnect()
      .sink { [weak self] _ in
        guard let self = self else { return }
        
        self.count += 1
        
        // demo for cancellables
        /*
         if self.count >= 10 {
           for item in self.cancellables {
             item.cancel()
           }
         }
         */
      }
      .store(in: &cancellables)
    
    
  }

  func addButtonSubscriber() {
    $textIsValid
      .combineLatest($count)
      .sink { [weak self] isValid, count in
        guard let self = self else { return }
        
        if isValid && count >= 10 {
          self.showButton = true
        } else {
          self.showButton = false
        }
      }
      .store(in: &cancellables)
  }
}

struct CustomerPublishersAndSubscribers: View {
  @StateObject private var vm = SubscriberViewModel()
  
  var body: some View {
    VStack {
      Text("\(vm.count)")
        .font(.largeTitle)
      
      // Text(vm.textIsValid.description)
      
      TextField("Type something here..", text: $vm.textFieldText)
        .padding(.leading)
        .frame(height: 55)
        .font(.headline)
        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
        .cornerRadius(10.0)
        .overlay(
          ZStack {
            Image(systemName: "xmark")
              .foregroundColor(.red)
              .opacity(vm.textFieldText.count < 1 ? 0.0 : vm.textIsValid ? 0 : 1.0)
            
            Image(systemName: "checkmark")
              .foregroundColor(.green)
              .opacity(vm.textIsValid ? 1.0 : 0)
            
            
          }
          .font(.headline)
          .padding(.trailing)
          , alignment: .trailing
        )
      
      Button(action: {}, label: {
        Text("Submit".uppercased())
          .font(.headline)
          .foregroundColor(.white)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
          .cornerRadius(10.0)
          .opacity(vm.showButton ? 1.0 : 0.5)
        
      })
      .disabled(!vm.showButton)
    }
    .padding()
  }
}

struct CustomerPublishersAndSubscribers_Previews: PreviewProvider {
  static var previews: some View {
    CustomerPublishersAndSubscribers()
  }
}
