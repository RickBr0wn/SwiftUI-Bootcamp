//
//  MultipleSheetsFromSingleView_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 28/06/2021.
//

import SwiftUI

struct RandomModel: Identifiable {
  let id = UUID().uuidString
  let title: String
}

struct NextScreen: View {
  let selectedModel: RandomModel
  
  var body: some View {
    Text("\(selectedModel.title)")
      .font(.largeTitle)
  }
}

struct MultipleSheetsFromSingleViewUsingBindingToItemModifier_: View {
  @State private var selectedModel: RandomModel? = nil
  
  var body: some View {
    ScrollView {
      VStack {
        ForEach(0..<50) { index in
          Button("Button #\(index)") {
            selectedModel = RandomModel(title: "\(index)")
          }
        }
      }
      .sheet(item: $selectedModel) { model in
        NextScreen(selectedModel: model)
      }
    }
  }
}

struct MultipleSheetsFromSingleViewUsingIsPresentedModifier_: View {
  @State private var selectedModel: RandomModel = RandomModel(title: "Starting title")
  @State private var showSheet: Bool = false
  @State private var showSecondSheet: Bool = false
  
  var body: some View {
    VStack(spacing: 20) {
      Button("Button #1") {
        showSheet.toggle()
      }
      .sheet(isPresented: $showSheet) {
        NextScreen(selectedModel: RandomModel(title: "one"))
      }
      
      Button("Button #2") {
        showSecondSheet.toggle()
      }
      .sheet(isPresented: $showSecondSheet) {
        NextScreen(selectedModel: RandomModel(title: "two"))
      }
    }
  }
}

struct MultipleSheetsFromSingleViewUsingBindingToItemModifier__Previews: PreviewProvider {
  static var previews: some View {
    MultipleSheetsFromSingleViewUsingBindingToItemModifier_()
  }
}
