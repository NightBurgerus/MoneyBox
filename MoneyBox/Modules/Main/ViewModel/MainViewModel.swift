//
//  MainViewModel.swift
//  MoneyBox
//
//  Created by Чебупелина on 15.08.2023.
//

import Foundation
import CoreData

class MainViewModel: ObservableObject {
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CDModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Cannot load persistent container")
            }
        }
        return container
    }()
    
    func loadItemsFromCoreData() -> [BoxAttributes] {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Box>(entityName: "Box")
        do {
            let result = try context.fetch(request)
            var attributes = [BoxAttributes]()
            for r in result {
                attributes.append(self.box2BoxAttribute(r))
            }
            return attributes
        } catch {
            print("~ error while load items from core data in MainViewModel: ", error)
            return []
        }
    }
    
    private func box2BoxAttribute(_ box: Box) -> BoxAttributes {
        let decoder = JSONDecoder()
        let income = (try? decoder.decode([MoneyTransaction].self, from: box.income ?? Data())) ?? []
        let waste = (try? decoder.decode([MoneyTransaction].self, from: box.waste ?? Data())) ?? []
        
        return BoxAttributes(name: box.name ?? "",
                             description: box.descript ?? "",
                             creationDate: box.creationDate ?? Date(),
                             income: income,
                             waste: waste,
                             finalValue: box.finalValue)
    }
    
    func saveNewBox(_ box: BoxAttributes) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Box", in: context)!
        let newBox = Box(entity: entity, insertInto: context)
        newBox.name = box.name
        newBox.descript = box.description
        newBox.creationDate = box.creationDate
        newBox.finalValue = box.finalValue
        newBox.startCapital = box.startCapital
        
        let encoder = JSONEncoder()
        let incomeData = try? encoder.encode(box.income)
        let wasteData = try? encoder.encode(box.waste)
        
        newBox.income = incomeData
        newBox.waste = wasteData
        
        do {
            try context.save()
        } catch {
            print("error while saving context in MainViewModel: ", error)
        }
    }
}
