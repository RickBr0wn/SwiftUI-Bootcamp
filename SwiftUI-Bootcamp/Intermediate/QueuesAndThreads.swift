//
//  QueuesAndThreads.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 14/07/2021.
//

import SwiftUI

class BackgroundThreadVM: ObservableObject {
  @Published var dataArray: Array<String> = []
  
  func fetchData() -> Void {
    DispatchQueue.global(qos: .background).async {
      let newData = self.downloadData()
      
      let isMainTread = Thread.isMainThread
      let currentThread = Thread.current
      
      print("globalThread")
      print("\(isMainTread)")
      print("\(currentThread)")
      
      DispatchQueue.main.async {
        print("mainThread")
        print("\(isMainTread)")
        print("\(currentThread)")
        self.dataArray = newData
      }
    }
  }
  
  private func downloadData() -> Array<String> {
    var data: Array<String> = []
    
    for x in 0..<100 {
      data.append("\(x)")
    }
    
    return data
  }
}

struct QueuesAndThreads: View {
  @StateObject private var vm = BackgroundThreadVM()
  var body: some View {
    ScrollView {
      VStack(spacing: 10) {
        Text("Load Data")
          .font(.largeTitle)
          .fontWeight(.semibold)
          .onTapGesture {
            vm.fetchData()
          }
        
        ForEach(vm.dataArray, id: \.self) { item in
          Text(item)
            .font(.headline)
            .fontWeight(.semibold)
        }
      }
    }
  }
}

struct QueuesAndThreads_Previews: PreviewProvider {
  static var previews: some View {
    QueuesAndThreads()
  }
}
