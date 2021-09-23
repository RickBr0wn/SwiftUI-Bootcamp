//
//  Generics_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 23/09/2021.
//

import SwiftUI

struct GenericModel<T> {
  let info: T?
  
  func removeInfo() -> GenericModel {
    GenericModel(info: nil)
  }
}

class GenericsViewModel: ObservableObject {
  @Published var exampleModel = GenericModel(info: "exampleModel")
  
  func removeData() {
    exampleModel = exampleModel.removeInfo()
  }
}

struct GenericView<T: View>: View {
  let content: T
  
  var body: some View {
    VStack {
      content
      Text("OK!")
    }
  }
}
 
struct Generics_: View {
  @StateObject private var vm = GenericsViewModel()
  
  var body: some View {
    VStack {
      Text(vm.exampleModel.info ?? "no data")
        .onTapGesture { vm.removeData() }
    }
  }
}

struct Generics__Previews: PreviewProvider {
  static var previews: some View {
    Generics_()
  }
}
