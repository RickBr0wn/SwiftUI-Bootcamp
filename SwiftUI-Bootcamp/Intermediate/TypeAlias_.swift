//
//  TypeAlias_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 14/07/2021.
//

import SwiftUI

struct MovieModel {
  let title: String
  let director: String
  let count: Int
}

typealias TelevisionModel = MovieModel

//struct TelevisionModel {
//  let title: String
//  let director: String
//  let count: Int
//}

struct TypeAlias_: View {
  @State private var movieModel =
    MovieModel(title: "The Movie Title", director: "Some movie director", count: 114)
  
  @State private var tvModel =
    TelevisionModel(title: "The Televsion Title", director: "Some television director", count: 114)
  
  var body: some View {
    VStack {
      Text(movieModel.title)
      Text(movieModel.director)
      Text(String(movieModel.count))
    }
  }
}

struct TypeAlias__Previews: PreviewProvider {
  static var previews: some View {
    TypeAlias_()
  }
}
