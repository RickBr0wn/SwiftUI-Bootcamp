//
//  Codable_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 08/07/2021.
//

import SwiftUI

class CodableViewModel: ObservableObject {
  @Published var customer: CustomerModel? = nil
  
  init() {
    getData()
  }
  
  func getData() -> Void {
    guard let data = getJSONData() else { return }
    try? self.customer = JSONDecoder().decode(CustomerModel.self, from: data)
    //    if
    //      let localData = try? JSONSerialization.jsonObject(with: data, options: []),
    //      let dictionary = localData as? [String:Any],
    //      let id = dictionary["id"] as? String,
    //      let name = dictionary["name"] as? String,
    //      let points = dictionary["points"] as? Int,
    //      let isPremium = dictionary["isPremium"] as? Bool {
    //
    //      let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
    //      customer = newCustomer
    //    }
  }
  
  func getJSONData() -> Data? {
    let dictionary: [String:Any] = [
      "id": "12",
      "name": "Rick",
      "points": 4,
      "isPremium": true
    ]
    let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
    return jsonData
  }
}

struct CustomerModel: Identifiable, Decodable {
  let id: String
  let name: String
  let points: Int
  let isPremium: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case points
    case isPremium
  }
  
  init(id: String, name: String, points: Int, isPremium: Bool) {
    self.id = id
    self.name = name
    self.points = points
    self.isPremium = isPremium
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    self.points = try container.decode(Int.self, forKey: .points)
    self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
  }
}

struct Codable_: View {
  @StateObject private var viewModel = CodableViewModel()
  
  var body: some View {
    VStack(spacing: 20) {
      if let customer = viewModel.customer {
        Text(customer.id)
        Text(customer.name)
        Text("\(customer.points)")
        Text(customer.isPremium.description)
      }
    }
  }
}

struct Codable__Previews: PreviewProvider {
  static var previews: some View {
    Codable_()
  }
}
