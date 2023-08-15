//
//  AddTransactionModel.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import Foundation


struct AddTransactionModel {
    let name: String
    let type: TransactionTypes
    let value: Double
    let unit: TimeUnit
}
