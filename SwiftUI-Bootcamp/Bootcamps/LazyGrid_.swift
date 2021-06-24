//
//  LazyGrid_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 24/06/2021.
//

import SwiftUI

struct LazyGrid_: View {
  // let columns: Array<GridItem> = [
  //   GridItem(.fixed(50), spacing: nil, alignment: nil),
  //   GridItem(.fixed(50), spacing: nil, alignment: nil),
  //   GridItem(.fixed(50), spacing: nil, alignment: nil),
  //   GridItem(.fixed(50), spacing: nil, alignment: nil)
  // ]
  
  let columns: Array<GridItem> = [
    GridItem(.flexible(), spacing: 20, alignment: nil),
    GridItem(.flexible(), spacing: 20, alignment: nil),
    GridItem(.flexible(), spacing: 20, alignment: nil),
  ]
  
  // let columns: Array<GridItem> = [
  //   GridItem(.adaptive(minimum: 10, maximum: 300), spacing: nil, alignment: nil),
  //   GridItem(.adaptive(minimum: 150, maximum: 300), spacing: nil, alignment: nil),
  // ]
  
  var body: some View {
    ScrollView {
      Rectangle()
        .fill(Color.white)
        .frame(height: 400)
      
      // LazyVGrid(columns: columns, content: {
      //   ForEach(1..<100) { _ in
      //     Rectangle()
      //       .frame(height: 150)
      //   }
      // })
      
      LazyVGrid(
        columns: columns,
        alignment: .center,
        spacing: 20,
        pinnedViews: [.sectionHeaders],
        content: {
          Section(header: Text("Title").font(.title)) {
            ForEach(0..<20) { _ in
              Rectangle()
                .fill(Color.pink)
                .frame(height: 150)
            }
          }
          
          Section(header: Text("Title 2").font(.title)) {
            ForEach(0..<20) { _ in
              Rectangle()
                .fill(Color.green)
                .frame(height: 150)
            }
          }
        }
      )
    }
  }
}

struct LazyGrid__Previews: PreviewProvider {
  static var previews: some View {
    LazyGrid_()
  }
}
