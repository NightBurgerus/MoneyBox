//
//  BoxViewModel.swift
//  MoneyBox
//
//  Created by Чебупелина on 15.08.2023.
//

import Foundation
import CoreData

class BoxViewModel: ObservableObject {
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CDModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("error while loading persistent container in BoxViewModel: \(error)")
            }
        }
        return container
    }()
    
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
}
