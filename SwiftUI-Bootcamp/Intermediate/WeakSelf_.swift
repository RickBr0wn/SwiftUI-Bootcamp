//
//  WeakSelf_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 14/07/2021.
//

import SwiftUI

enum Constants: String {
  case count
}

struct WeakSelf_: View {
  @AppStorage(Constants.count.rawValue) var count: Int?
  
  init() {
    count = 0
  }
  
  var body: some View {
    NavigationView {
      NavigationLink("Goto Screen #2".uppercased(), destination: WeakSelfSecondScreen())
        .navigationTitle("Screen #1")
    }
    .overlay(
      (Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color(#colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)))
        .cornerRadius(10.0))
      , alignment: .topTrailing)
    .padding()
  }
}

class WeakSelfVM: ObservableObject {
  @Published var data: String = Constants.count.rawValue
  
  private var key: String = Constants.count.rawValue
  
  init() {
    print("initialising WeakSelfVM")
    let currentCount = UserDefaults.standard.integer(forKey: key)
    UserDefaults.standard.set(currentCount + 1, forKey: key)
    getData()
  }
  
  deinit {
    print("de-initialising WeakSelfVM")
    let currentCount = UserDefaults.standard.integer(forKey: key)
    UserDefaults.standard.set(currentCount -  1, forKey: key)
  }
  
  func getData() -> Void {
    DispatchQueue.main.asyncAfter(deadline: .now() + 60) { [weak self] in
      self?.data = "NEW DATA!!"
    }
  }
}

struct WeakSelfSecondScreen: View {
  @StateObject var vm = WeakSelfVM()
  
  var body: some View {
    VStack {
      Text("Screen #2".uppercased())
      
      if let data = vm.data {
        Text(data)
      }
    }
  }
}

struct WeakSelf__Previews: PreviewProvider {
  static var previews: some View {
    WeakSelf_()
  }
}
