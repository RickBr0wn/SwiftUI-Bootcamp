//
//  CoreData_.swift
//  SwiftUI-Bootcamp
//
//  Created by Rick Brown on 28/06/2021.
//

import SwiftUI
import CoreData
/**
 MVVM
 
 Model - The model for the data.
 View - The UI components.
 View Model - The model to control the view.
 
 */

class CoreDataViewModel: ObservableObject {
  let container: NSPersistentContainer
  @Published var savedEntities: Array<FruitEntity> = []
  
  init() {
    container = NSPersistentContainer(name: "FruitsContainer")
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Error loading CoreData: \(error)")
      }
    }
    fetchFruitsFromCoreData()
  }
  
  func fetchFruitsFromCoreData() {
    let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
    do {
      savedEntities = try container.viewContext.fetch(request)
    } catch let error {
      print("\(error)")
    }
  }
  
  func addNewFruitToCoreData(text: String) {
    let newFruit = FruitEntity(context: container.viewContext)
    newFruit.name = text
    saveDataToCoreData()
  }
  
  func deleteFruitFromCoreData(indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    let entity = savedEntities[index]
    container.viewContext.delete(entity)
    saveDataToCoreData()
  }
  
  func updateFruitFromCoreData(entity: FruitEntity) {
    let currentName = entity.name ?? ""
    let newName = currentName + "!"
    entity.name = newName
    saveDataToCoreData()
  }
  
  func saveDataToCoreData() {
    do {
      try container.viewContext.save()
      fetchFruitsFromCoreData()
    } catch let error {
      print("\(error)")
    }
  }
}

struct CoreData_: View {
  @StateObject private var viewModel = CoreDataViewModel()
  @State private var textFieldText: String = ""
  
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        TextField("Add fruit here..", text: $textFieldText)
          .font(.headline)
          .padding(.leading)
          .frame(height: 55)
          .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
          .cornerRadius(10.0)
          .padding(.horizontal)
        
        Button(action: {
          guard !textFieldText.isEmpty else { return }
          viewModel.addNewFruitToCoreData(text: textFieldText)
          textFieldText = ""
        }, label: {
          Text("Submit".uppercased())
            .font(.headline)
            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)))
            .cornerRadius(10.0)
            .padding(.horizontal)
        })
        
        List {
          ForEach(viewModel.savedEntities) { entity in
            Text(entity.name ?? "⚠️ No name".uppercased())
              .onTapGesture {
                viewModel.updateFruitFromCoreData(entity: entity)
              }
          }
          .onDelete(perform: viewModel.deleteFruitFromCoreData)
        }
        .listStyle(PlainListStyle())
      }
      .navigationTitle("Fruits")
    }
  }
}

struct CoreData__Previews: PreviewProvider {
  static var previews: some View {
    CoreData_()
  }
}
