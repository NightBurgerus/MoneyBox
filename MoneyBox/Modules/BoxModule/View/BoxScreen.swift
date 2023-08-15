//
//  BoxScreen.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI

struct BoxScreen: View {
    @Binding var boxAttributes: BoxAttributes
    @State private var showFullDescription = true
    @State private var circleAttributes: CircleAttributes? = nil
    @State private var descriptionHeight: CGFloat? = nil
    
    var body: some View {
        VStack {
            ScrollView {
                goalView
                descriptionView
                incomeLink
                wasteLink
                Spacer()
                if let attr = circleAttributes {
                    CircleProgress(attributes: attr)
                }
                Spacer()
            }.padding(5)
        }
        .viewWillAppear {
            DispatchQueue.main.async {
                self.circleAttributes = getCircleAttributes()
            }
        }
        .background(GradientView())
        .frame(width: Const.bounds.width)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(boxAttributes.name)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
    }
    
    private func getCircleAttributes() -> CircleAttributes {
        let incomePerSecond = boxAttributes.income.map({ $0.value / Double($0.unit.seconds()) }).reduce(0, +)
        let wastePerSecond  = boxAttributes.waste.map({ $0.value / Double($0.unit.seconds()) }).reduce(0, +)
        let step = incomePerSecond - wastePerSecond
        
        let currentValue = Date().timeIntervalSince(boxAttributes.creationDate) * step + boxAttributes.startCapital
        return CircleAttributes(value: currentValue, finishValue: boxAttributes.finalValue, step: step)
    }
}

extension BoxScreen {
    private var goalView: some View {
        HStack {
            Text("Цель: ")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            Text(String(format: "%.02f", boxAttributes.finalValue))
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
            Spacer()
        }.padding(.top, 10)
    }
    private var descriptionView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Описание")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Text(boxAttributes.description)
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .background( GeometryReader { geo in
                            Color.clear.onAppear {
                                self.descriptionHeight = geo.size.height
                                showFullDescription = geo.size.height < 100
                            }
                        })
                    Spacer()
                }
            }.frame(height: showFullDescription ? nil : Optional(100))
            
            if (descriptionHeight ?? 0) > 100 {
                Button {
                    withAnimation {
                        showFullDescription.toggle()
                    }
                } label: {
                    Text("\(showFullDescription ? "Скрыть" : "Показать") описание")
                }
            }

        }
    }
    
    private var incomeLink: some View {
        NavigationLink(destination: IncomeWasteScreen(income: $boxAttributes.income, waste: $boxAttributes.waste)) {
            HStack {
                Text("Доходы")
                    .foregroundColor(.white)
                Spacer()
                Text("\(boxAttributes.income.count)")
                    .foregroundColor(.white)
            }
            .frame(height: 50)
        }
    }
    
    private var wasteLink: some View {
        NavigationLink(destination: IncomeWasteScreen(income: $boxAttributes.income, waste: $boxAttributes.waste)) {
            HStack {
                Text("Расходы")
                    .foregroundColor(.white)
                Spacer()
                Text("\(boxAttributes.waste.count)")
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .padding(.bottom, 20)
        }
    }
}
