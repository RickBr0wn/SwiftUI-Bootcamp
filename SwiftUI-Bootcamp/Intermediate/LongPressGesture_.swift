//
//  LongPressGesture_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 24/06/2021.
//

import SwiftUI

struct LongPressGesture_: View {
  @State private var isComplete: Bool = false
  @State private var isSuccessful: Bool = false
  
  var body: some View {
    //        Text(isComplete ? "Completed" : "Not Complete")
    //          .padding()
    //          .padding(.horizontal)
    //          .background(isComplete ? Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)) : Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
    //          .cornerRadius(10.0)
    //          .onTapGesture {
    //            isComplete.toggle()
    //          }
    //          .onLongPressGesture(minimumDuration: 1.0) {
    //            isComplete.toggle()
    //          }
    
    VStack {
      Rectangle()
        .fill(isSuccessful ? Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)) : Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
        .frame(maxWidth: isComplete ? .infinity : 0)
        .frame(height: 50)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
      
      HStack {
        Text("Click here".uppercased())
          .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
          .padding()
          .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
          .cornerRadius(10.0)
          .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
            // start of press -> minimumDuration (param)
            if isPressing {
              withAnimation(.easeInOut(duration: 1.0)) {
                isComplete = true
              }
            } else {
              withAnimation(.easeInOut) {
                isComplete = false
              }
            }
          } perform: {
            // fires at the minimumDuration (param)
            withAnimation(.easeInOut) {
              isSuccessful = true
            }
          }

        Text("Reset".uppercased())
          .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
          .padding()
          .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
          .cornerRadius(10.0)
        
      }
    }
  }
}

struct LongPressGesture__Previews: PreviewProvider {
  static var previews: some View {
    LongPressGesture_()
  }
}
