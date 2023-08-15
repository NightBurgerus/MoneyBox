//
//  Box+CoreDataProperties.swift
//  MoneyBox
//
//  Created by Чебупелина on 15.08.2023.
//
//

import Foundation
import CoreData


extension Box {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Box> {
        return NSFetchRequest<Box>(entityName: "Box")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var descript: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var finalValue: Double
    @NSManaged public var startCapital: Double
    @NSManaged public var income: Data?
    @NSManaged public var waste: Data?

}

extension Box : Identifiable {

}
