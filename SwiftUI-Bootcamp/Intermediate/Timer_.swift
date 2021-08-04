//
//  Timer_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 04/08/2021.
//

import SwiftUI

struct Timer_: View {
  let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
  
  // Current Time
  /**
   @State private var currentDate: Date = Date()
   
   private var dateFormatter: DateFormatter {
   let formatter = DateFormatter()
   formatter.timeStyle = .short
   return formatter
   }
   */
  
  // Countdown
  /*
   @State private var count: Int = 10
   @State private var finishedText: String? = nil
   */
  
  // Countdown to date
  /*
   @State private var timeRemaining: String = ""
   let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
   
   func updateTimeRemaining() {
   let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
   let hour = remaining.hour ?? 0
   let minute = remaining.minute ?? 0
   let second  = remaining.second ?? 0
   timeRemaining = "\(hour):\(minute):\(second)"
   }
   */
  
  // Animation Counter
  @State private var count: Int = 0
  
  var body: some View {
    ZStack {
      RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))]), center: .center
                     , startRadius: 5, endRadius: 500)
        .ignoresSafeArea()
      
      // Text for countdown
      /*
       Text(timeRemaining)
       .font(.system(size: 100, weight: .semibold, design: .rounded))
       .foregroundColor(.white)
       .lineLimit(1)
       .minimumScaleFactor(0.1)
       .padding()
       */
      
      // Loading Animation Stack
      /*
       HStack(spacing: 15) {
       Circle()
       .offset(y: count == 1 ? -20 : 0)
       Circle()
       .offset(y: count == 2 ? -20 : 0)
       Circle()
       .offset(y: count == 3 ? -20 : 0)
       }
       .frame(width: 150)
       .foregroundColor(.white)
       */
    
      TabView(selection: $count,
              content:  {
                Rectangle()
                  .foregroundColor(.red)
                  .tabItem {
                    Image(systemName: "house")
                  }.tag(1)
                Rectangle()
                .foregroundColor(.blue)
                  .tabItem {
                    Image(systemName: "gear")
                  }.tag(2)
                Rectangle()
                  .foregroundColor(.green)
                  .tabItem {
                    Image(systemName: "gamecontroller.fill")
                  }.tag(3)
                Rectangle()
                  .foregroundColor(.orange)
                  .tabItem {
                    Image(systemName: "exclamationmark.bubble.fill")
                  }.tag(4)
                Rectangle()
                  .foregroundColor(.pink)
                  .tabItem {
                    Image(systemName: "slider.horizontal.3")
                  }.tag(5)
              }).frame(height: 200)
        .tabViewStyle(PageTabViewStyle())
    }
    .onReceive(timer, perform: { _ in
      // Countdown
      /*
       if count <= 1 {
       finishedText = "Wow!"
       } else {
       count -= 1
       }
       */
      
      // updateTimeRemaining()
      
      // Loading Animation Stack
      /*
       withAnimation(.easeInOut(duration: 0.5)) {
       count = count == 3 ? 0 : count + 1
       }
       */
    
      withAnimation(.easeInOut(duration: 0.5)) {
        count = count == 5 ? 1 : count + 1
      }
    })
  }
}

struct Timer__Previews: PreviewProvider {
  static var previews: some View {
    Timer_()
  }
}
