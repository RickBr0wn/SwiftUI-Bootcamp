//
//  @escaping_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 14/07/2021.
//

import SwiftUI

struct DownloadResult {
  let data: String
}

class EscapingVM: ObservableObject {
  @Published var text: String = "OK"
  
  func getData() -> Void {
    downloadDataWithEscapingButBetter { [weak self] (returnedData) in
      self?.text = returnedData.data
    }
    
    doSomething(for: "xyz")
  }
  
  private func downloadData() -> String {
    return "NEW DATA!!"
  }

  private func downloadDataBadly(completion: (_ data: String) -> Void) -> Void {
    completion("NEW DAATAAAAAAAAAAAA")
  }
  
  private func doSomething(for data: String) -> Void {
    print(data)
  }
  
  private func downloadDataWithEscaping(completionHandler: @escaping (_ data: String) -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      completionHandler("MORE DATA!")
    }
  }
  
  private func downloadDataWithEscapingButBetter(completionHandler: @escaping (DownloadResult) -> ()) {
    let result = DownloadResult(data: "MORE DATA BUT BETTER!")
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      completionHandler(result)
    }
  }
}

struct AtEscapingClosures: View {
  @StateObject private var vm = EscapingVM()
  
  var body: some View {
    Text(vm.text)
      .font(.largeTitle)
      .fontWeight(.semibold)
      .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
      .onTapGesture {
        vm.getData()
      }
  }
}

struct AtEscapingClosures_Previews: PreviewProvider {
  static var previews: some View {
    AtEscapingClosures()
  }
}
