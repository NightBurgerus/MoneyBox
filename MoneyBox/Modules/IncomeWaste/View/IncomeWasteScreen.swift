//
//  IncomeWasteScreen.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI

struct IncomeWasteScreen: View {
    @State var income: [MoneyTransaction]
    @State var waste: [MoneyTransaction]
    let onChange: (([MoneyTransaction], [MoneyTransaction]) -> Void)?
    @State private var addButtonType: TransactionTypes = .income
    @State private var addTransactionSheetShowing = false
    
    var body: some View {
        VStack {
            label
            List {
                Section(header:
                    Text("Доходы")
                        .foregroundColor(.white)
                    ){
                    ForEach(0..<income.count, id: \.self) { i in
                        row(for: income[i])
                    }
                    .onDelete { indexes in
                        guard let index = indexes.randomElement() else { return }
                        income.remove(at: index)
                        onChange?(income, waste)
                    }
                    
                    addButton(type: .income)
                }.listRowBackground(Color.clear)
                
                Section(header:
                    Text("Расходы")
                        .foregroundColor(.white)
                ) {
                    ForEach(0..<waste.count, id: \.self) { i in
                        row(for: waste[i])
                    }
                    .onDelete { indexes in
                        guard let index = indexes.randomElement() else { return }
                        waste.remove(at: index)
                        onChange?(income, waste)
                    }
                    
                    addButton(type: .waste)
                }.listRowBackground(Color.clear)
            }
            .sheet(isPresented: $addTransactionSheetShowing) {
                AddTransactionScreen(typePicker: addButtonType) { newTransaction in
                    if newTransaction.type == .income {
                        income.append(MoneyTransaction(name: newTransaction.name,value: newTransaction.value, unit: newTransaction.unit))
                    } else {
                        waste.append(MoneyTransaction(name: newTransaction.name,value: newTransaction.value, unit: newTransaction.unit))
                    }
                    onChange?(income, waste)
                }
            }
        }
        .background(GradientView())
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formattedPrice(for transaction: MoneyTransaction) -> String {
        var result = String(format: "%.2f", transaction.value)
        switch transaction.unit {
        case .year: result += "/год"
        case .month: result += "/месяц"
        case .week: result += "/неделя"
        case .day: result += "/день"
        case .hour: result += "/час"
        case .minute: result += "/минута"
        case .second: result += "/секунда"
        }
        return result
    }
}

extension IncomeWasteScreen {
    private var label: some View {
        HStack {
            Spacer()
            Text("Доходы и расходы")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
                .padding(.vertical, 10)
            Spacer()
        }
    }
    private func addButton(type: TransactionTypes) -> some View {
        Button {
            addButtonType = type
            addTransactionSheetShowing.toggle()
        } label: {
            Text("Добавить")
        }
    }
    
    private func row(for transaction: MoneyTransaction) -> some View {
        HStack {
            Text(transaction.name)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            Text(formattedPrice(for: transaction))
                .font(.system(size: 17))
                .foregroundColor(.white)
        }
    }
}
