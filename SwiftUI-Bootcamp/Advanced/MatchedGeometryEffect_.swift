//
//  MatchedGeometryEffect_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 11/09/2021.
//

import SwiftUI

//struct MatchedGeometryEffect_: View {
//  @State private var isClicked: Bool = false
//  @Namespace private var namespace
//
//  var body: some View {
//    VStack {
//      if isClicked {
//        RoundedRectangle(cornerRadius: 25.0)
//          .matchedGeometryEffect(id: "rectangle", in: namespace)
//          .frame(width: 100, height: 100)
//        Spacer()
//      } else {
//        Spacer()
//        RoundedRectangle(cornerRadius: 25.0)
//          .matchedGeometryEffect(id: "rectangle", in: namespace)
//          .frame(width: 400, height: 400)
//      }
//    }
//    .frame(maxWidth: .infinity, maxHeight: .infinity)
//    .background(Color.red.edgesIgnoringSafeArea(.all))
//    .onTapGesture { withAnimation(.easeInOut) { isClicked.toggle() } }
//  }
//}

/*
 The animation in the following example looks broken on preview. But runs eprfectly fine on the simulator.
 */
struct AnotherMatchedGeometryEffect_: View {
  let categories = ["Home", "Popular", "Saved"]
  @State private var selected: String = ""
  @Namespace private var anoterNamespace
  private let namespaceId: String = "category_background"
  
  var body: some View {
    HStack {
      ForEach(categories, id: \.self) { category in
        ZStack(alignment: .bottom) {
          if selected == category {
            RoundedRectangle(cornerRadius: 10.0)
              .fill(Color.red.opacity(0.3))
              .matchedGeometryEffect(id: namespaceId, in: anoterNamespace)
              .frame(width: 35, height: 2)
              .offset(y: 10)
          }
          Text(category)
            .foregroundColor(selected == category ? .red : .black)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .onTapGesture { withAnimation(.spring()) { selected = category } }
      }
    }
    .padding()
  }
}

struct MatchedGeometryEffect__Previews: PreviewProvider {
  static var previews: some View {
    AnotherMatchedGeometryEffect_()
  }
}
