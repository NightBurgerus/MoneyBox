//
//  BoxAttributes.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import Foundation

struct BoxAttributes {
    let name: String
    let description: String
    let creationDate: Date
    let income: [MoneyTransaction]
    let waste: [MoneyTransaction]
    let finalValue: Double
}


enum TimeUnit {
    case year, month, day, hour, minute, second
    
    func seconds() -> Int {
        switch self {
        case .year: return 60 * 60 * 24 * 365
        case .month: return 60 * 60 * 24 * 30
        case .day: return 60 * 60 * 24
        case .hour: return 60 * 60
        case .minute: return 60
        case .second: return 1
        }
    }
}

struct MoneyTransaction {
    var name: String
    var value: Double
    var unit: TimeUnit
}
