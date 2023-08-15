//
//  AddBoxView.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI

struct AddBoxView: View {
    let completion: ((BoxAttributes) -> ())?
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var description = ""
    @State private var finalValue = ""
    @State private var startCapital = ""
    @State private var income: [MoneyTransaction] = []
    @State private var waste: [MoneyTransaction] = []
    @State private var onChangeTransactionCount: (([MoneyTransaction], [MoneyTransaction]) -> Void)?
    
    var body: some View {
        VStack {
            Group {
                label
                
                nameView
                descriptionView
                transactionView
                
                goalView
                startCapitalView
                Spacer()
                addButton
            }
            .padding(.horizontal, 10)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            endEditing()
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(GradientView())
        .onAppear {
            onChangeTransactionCount = { income, waste in
                self.income = income
                self.waste = waste
            }
        }
    }
    
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension AddBoxView {
    private var label: some View {
        Text("Добавление новой цели")
            .font(.system(size: 27, weight: .heavy))
            .foregroundColor(.white)
    }
    
    private var nameView: some View {
        HStack {
            Text("Название")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white.opacity(0.125))
                TextField("Название", text: $name, onCommit: { endEditing() })
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
            }
        }
        .frame(height: 30)
        .padding(.bottom, 20)
    }
    
    private var descriptionView: some View {
        VStack {
            HStack {
                Text("Описание")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white.opacity(0.125))
                TextEditor(text: $description)
                    .onSubmit {
                        endEditing()
                    }
                    .foregroundColor(.white)
                    .padding(5)
            }
            .frame(height: 100)
            .onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
        }
        .padding(.bottom, 20)
    }
    
    private var transactionView: some View {
        Group {
            NavigationLink {
                IncomeWasteScreen(income: income, waste: waste, onChange: onChangeTransactionCount)
            } label: {
                HStack {
                    Text("Доходы")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(income.count)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white.opacity(0.75))
                }
                .frame(height: 30)
                .padding(.bottom, 10)
            }
            
            NavigationLink {
                IncomeWasteScreen(income: income, waste: waste, onChange: onChangeTransactionCount)
            } label: {
                HStack {
                    Text("Расходы")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(waste.count)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white.opacity(0.75))
                }
                .frame(height: 30)
                .padding(.bottom, 20)
            }
        }
        
    }
    
    private var goalView: some View {
        HStack {
            Text("Конечная цель: ")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white.opacity(0.125))
                TextField("", text: $finalValue, onCommit: { endEditing() })
                    .keyboardType(.decimalPad)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
            }
        }
        .frame(height: 30)
    }
    
    private var startCapitalView: some View {
        HStack {
            Text("Начальный \nкапитал ")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white.opacity(0.125))
                TextField("", text: $startCapital, onCommit: { endEditing() })
                    .keyboardType(.decimalPad)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
            }.frame(height: 30)
        }
        .frame(height: 60)
    }
    
    private var addButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.red)
            Text("Добавить")
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 75)
        .contentShape(Rectangle())
        .onTapGesture {
            guard let goal = Double(finalValue.replacingOccurrences(of: ",", with: ".")), !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                endEditing()
                dismiss()
                return
            }
            let newBox = BoxAttributes(id: UUID(), name: name, description: description, creationDate: Date(), income: income, waste: waste, finalValue: goal, startCapital: Double(startCapital.replacingOccurrences(of: ",", with: ".")) ?? 0.0)
            endEditing()
            completion?(newBox)
            dismiss()
        }
    }
}
