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
                attributes.append(BoxAdapter.convertToAttributes(box: r))
            }
            return attributes
        } catch {
            print("~ error while load items from core data in MainViewModel: ", error)
            return []
        }
    }
    
    func update(object: BoxAttributes) -> Bool {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Box>(entityName: "Box")
        do {
            var results = try context.fetch(request)
            var controlCount = 0
            for i in 0..<results.count {
                if results[i].id == object.id {
                    BoxAdapter.copy(box: object, in: &results[i])
                    break
                }
                controlCount += 1
            }
            if controlCount == results.count {
                print("not found")
                return false
            }
            
            try context.save()
            return true
        } catch {
            print("some error while update value in BoxViewModel: ", error)
            return false
        }
    }
    
    func saveNewBox(_ box: BoxAttributes) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Box", in: context)!
        let newBox = Box(entity: entity, insertInto: context)
        newBox.id = box.id
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
    
    func delete(object: BoxAttributes) -> Bool {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<Box>(entityName: "Box")
        if let results = try? context.fetch(request) {
            var controllCount = 0
            for item in results {
                if self.compare(box: item, boxAttr: object) {
                    context.delete(item)
                    break
                }
                controllCount += 1
            }
            if controllCount == results.count {
                print("not found")
                return false
            }
        } else {
            print("no results")
            return false
        }
        
        
        do {
            try context.save()
            return true
        } catch {
            print("error while deleting object in MainViewModel: ", error)
            return false
        }
    }
    
    func compare(box: Box, boxAttr: BoxAttributes) -> Bool {
        return box.id == boxAttr.id
    }
}
