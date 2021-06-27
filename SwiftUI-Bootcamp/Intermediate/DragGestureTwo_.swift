//
//  DragGestureTwo_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 27/06/2021.
//

import SwiftUI

struct DragGestureTwo_: View {
  @State private var startingDragOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
  @State private var currentDragOffsetY: CGFloat = .zero
  @State private var endingDragOffsetY: CGFloat = .zero
  
  var body: some View {
    ZStack {
      Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        Text("\(startingDragOffsetY)")
        
        Text("\(currentDragOffsetY)")
        
        Text("\(endingDragOffsetY)")
      }
      
      SignUpView()
        .offset(y: startingDragOffsetY)
        .offset(y: currentDragOffsetY)
        .offset(y: endingDragOffsetY)
        .gesture(dragGesture())
    }
  }
  
  private func dragGesture() -> some Gesture {
    return DragGesture()
      .onChanged { value in
        withAnimation(.spring()) {
          currentDragOffsetY = value.translation.height
        }
      }
      .onEnded { value in
        withAnimation(.spring()) {
          if currentDragOffsetY < -150 {
            endingDragOffsetY = -startingDragOffsetY
          } else if endingDragOffsetY != 0 && currentDragOffsetY > 150 {
            endingDragOffsetY = .zero
          }
          currentDragOffsetY = .zero
        }
      }
  }
}


struct SignUpView: View {
  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: "chevron.up")
        .padding(.top)
      
      Text("Sign up")
        .font(.headline)
        .fontWeight(.bold)
      
      Image(systemName: "flame.fill")
        .resizable()
        .scaledToFit()
        .frame(width: 100, height: 100)
      
      Text("Lorem ipsum dolor sit amet, odio scaevola no eum. Iudico nostrud persequeris quo ut. Duo modo accusam expetenda eu, congue labitur adolescens eam ne.")
        .multilineTextAlignment(.center)
        .padding()
      
      Text("Create an account".uppercased())
        .foregroundColor(.white)
        .font(.headline)
        .padding()
        .padding(.horizontal)
        .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
        .cornerRadius(10.0)
      
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
    .cornerRadius(30.0)
    
  }
}

struct DragGestureTwo__Previews: PreviewProvider {
  static var previews: some View {
    DragGestureTwo_()
  }
}
