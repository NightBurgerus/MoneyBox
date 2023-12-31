//
//  BoxAttributes.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import Foundation

struct BoxAttributes: Identifiable {    
    let id: UUID
    let name: String
    let description: String
    let creationDate: Date
    var income: [MoneyTransaction]
    var waste: [MoneyTransaction]
    let finalValue: Double
    let startCapital: Double
    
    init(id: UUID, name: String, description: String, creationDate: Date, income: [MoneyTransaction], waste: [MoneyTransaction], finalValue: Double, startCapital: Double = 0.0) {
        self.id = id
        self.name = name
        self.description = description
        self.creationDate = creationDate
        self.income = income
        self.waste = waste
        self.finalValue = finalValue
        self.startCapital = startCapital
    }
}


enum TimeUnit: Int, CaseIterable, Codable {
    case year, month, week, day, hour, minute, second
    
    func seconds() -> Int {
        switch self {
        case .year: return 60 * 60 * 24 * 365
        case .month: return 60 * 60 * 24 * 30
        case .week: return 60 * 60 * 24 * 7
        case .day: return 60 * 60 * 24
        case .hour: return 60 * 60
        case .minute: return 60
        case .second: return 1
        }
    }
    
    static func value(from string: String) -> Self {
        switch string.lowercased() {
        case "год": return .year
        case "месяц": return .month
        case "неделя": return .week
        case "день": return .day
        case "час": return .hour
        case "минута": return .minute
        default: return .second
        }
    }
}

struct MoneyTransaction: Codable {
    var name: String
    var value: Double
    var unit: TimeUnit
}
