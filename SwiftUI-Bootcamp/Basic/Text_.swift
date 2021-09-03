//
//  Text_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 11/06/2021.
//

import SwiftUI

struct Text_: View {
  var body: some View {
    ZStack {
      Color.purple.edgesIgnoringSafeArea(.all)
      
      VStack {
        Text("Hello, World!")
          .font(.body)
          .fontWeight(.bold)
          .underline(true, color: Color.blue)
          .italic()
        // .strikethrough(true, color: Color.green)
        
        Text("another text field".capitalized)
          .font(.system(size: 24, weight: .heavy, design: .monospaced))
        
        Text("Paneer camembert de normandie st. agur blue cheese. Lancashire say cheese macaroni cheese pecorino edam bavarian bergkase pecorino cheesy grin. Croque monsieur macaroni cheese paneer edam croque monsieur camembert de normandie taleggio cheese on toast. Feta croque monsieur cheese strings monterey jack cheese slices boursin stilton rubber cheese. Airedale danish fontina.")
          .kerning(10
          )
          .multilineTextAlignment(.center)
          .frame(width: 250, height: .infinity, alignment: .center)
        
        
      }
      .padding()
    }
  }
}

struct Text__Previews: PreviewProvider {
  static var previews: some View {
    Text_()
  }
}
