//
//  ContentView.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var goals: [BoxAttributes] = []
    @State private var selectedGoalsIndex: Int = 0
    @State private var action: Int? = nil
    @State private var addSheedShowing = false
    
    var body: some View {
        NavigationView {
            VStack {
                if goals.count > 0 {
                    NavigationLink(destination: BoxScreen(boxAttributes: goals[selectedGoalsIndex]), tag: 1, selection: $action) {}
                }
                ScrollView {
                    ForEach(0..<goals.count, id: \.self) { i in
                        HStack {
                            Text(goals[i].name)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
                        .frame(height: 50)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedGoalsIndex = i
                            action = 1
                        }

                    }
                    .onDelete { _set in
                        guard let index = _set.randomElement() else { return }
                        goals.remove(at: index)
                    }
                }
                .padding(.top, 50)
            }
            .sheet(isPresented: $addSheedShowing, content: {
                AddBoxView()
            })
            .frame(width: Const.bounds.width, height: Const.bounds.height)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("MoneyBox")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addSheedShowing.toggle()
                    } label: {
                        Text("+")
                            .font(.system(size: 30, weight: .bold))
                    }

                }
            }
            .background(GradientView())
            .onAppear {
                configureView()
            }
            
        }
    }
    
    private func configureView() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
        UITableView.appearance().separatorColor = UIColor.white
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = nil
        UINavigationBar.appearance().standardAppearance = appearance
        
        for i in 0...5 {
            goals.append(BoxAttributes(name: "Test\(i + 1)", description: "Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. Какое-то длинное-длинное описание тестового экрана задач. ", creationDate: Date(), income: [MoneyTransaction(name: "Что-то", value: 10, unit: .minute)], waste: [], finalValue: 20000))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
