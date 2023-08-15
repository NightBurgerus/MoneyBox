//
//  BoxAdapter.swift
//  MoneyBox
//
//  Created by Чебупелина on 15.08.2023.
//

import Foundation

class BoxAdapter {
    static func convertToAttributes(box: Box) -> BoxAttributes {
        let decoder = JSONDecoder()
        let income = (try? decoder.decode([MoneyTransaction].self, from: box.income ?? Data())) ?? []
        let waste = (try? decoder.decode([MoneyTransaction].self, from: box.waste ?? Data())) ?? []
        
        return BoxAttributes(id: box.id ?? UUID(),
                             name: box.name ?? "",
                             description: box.descript ?? "",
                             creationDate: box.creationDate ?? Date(),
                             income: income,
                             waste: waste,
                             finalValue: box.finalValue)
    }
    
    static func copy(box: BoxAttributes, in boxCD: inout Box) {
        let encoder = JSONEncoder()
        let incomeData = try? encoder.encode(box.income)
        let wasteData = try? encoder.encode(box.waste)
        boxCD.id = box.id
        boxCD.name = box.name
        boxCD.descript = box.description
        boxCD.creationDate = box.creationDate
        boxCD.income = incomeData
        boxCD.waste = wasteData
        boxCD.finalValue = box.finalValue
        boxCD.startCapital = box.startCapital
    }
}
