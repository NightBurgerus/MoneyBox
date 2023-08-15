//
//  AddTransactionScreen.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI

enum TransactionTypes: String, CaseIterable {
    case income = "Доходы"
    case waste = "Расходы"
}

struct AddTransactionScreen: View {
    @State var typePicker = TransactionTypes.income
    let completion: ((AddTransactionModel) -> ())?
    @State private var name = ""
    @State private var value = ""
    @State private var units = TimeUnit.year
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            label
            typeView
            nameView
            valueView
            transactionPeriodView
            
            Spacer()
            addButton
        }
        .background(GradientView())
    }
    
    private func formattedUnits(_ units: TimeUnit) -> String {
        switch units {
        case .year:
            return "Год"
        case .month:
            return "Месяц"
        case .day:
            return "День"
        case .hour:
            return "Час"
        case .minute:
            return "Минута"
        case .second:
            return "Секунда"
        }
    }
}

extension AddTransactionScreen {
    private var label: some View {
        HStack {
            Spacer()
            Text("Добавить \(typePicker == .income ? "доход" : "расход")ы")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 50)
                .padding(.bottom, 10)
            Spacer()
        }
    }
    private var typeView: some View {
        HStack {
            Text("Тип")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            Picker("", selection: $typePicker) {
                ForEach(TransactionTypes.allCases, id: \.self) { trans in
                    Text(trans.rawValue)
                }
            }
            .accentColor(AppColors.lightBlue)
            .font(.system(size: 15))
        }
        .padding(10)
        
    }
    private var nameView: some View {
        HStack {
            Text("Название")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.15))
                TextField("", text: $name)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
            }
        }
        .frame(height: 30)
        .padding([.leading, .trailing, .bottom], 10)
    }
    private var valueView: some View {
        HStack {
            Text("\(typePicker == .income ? "Доходы" : "Расходы")")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.15))
                TextField("", text: $value)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .keyboardType(.decimalPad)
            }
        }
        .frame(height: 30)
        .padding([.leading, .trailing, .bottom], 10)
    }
    
    private var transactionPeriodView: some View {
        Group {
            HStack {
                Text("За период")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
            }
            Picker("", selection: $units) {
                ForEach(TimeUnit.allCases, id: \.self) { u in
                    Text(formattedUnits(u))
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }
                .onChange(of: units) { _ in
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
            .pickerStyle(.wheel)
        }
        .frame(height: 30)
        .padding([.leading, .trailing, .bottom], 10)
        .padding(.top, 50)
    }
    
    private var addButton: some View {
        HStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(.red)
                Text("Добавить")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                add()
            }
            .frame(width: 150, height: 75)
            Spacer()
        }
    }
    
    private func add() {
        guard let goal = Double(value.replacingOccurrences(of: ",", with: ".")), !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                !value.isEmpty else {
            dismiss()
            return
        }
        completion?(AddTransactionModel(name: name, type: typePicker, value: goal, unit: units))
        dismiss()
    }
}

