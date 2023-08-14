//
//  AddBoxView.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI

struct AddBoxView: View {
    let completion: ((BoxAttributes?) -> ())? = nil
    @State private var name = ""
    @State private var description = ""
    @State private var finalValue = ""
    
    var body: some View {
        VStack {
            Text("Добавление новой цели")
            
            HStack {
                Text("Название")
                Spacer()
            }
            
            TextField("Название", text: $name)
            
            TextEditor(text: $description)
                .border(Color.gray)
                .frame(height: 100)
            
            TextField("Конечная цель", text: $finalValue)
                .keyboardType(.numberPad)
            Spacer()
        }
        .onDisappear {
            print("on disappear")
        }
    }
}

struct AddBoxView_Previews: PreviewProvider {
    static var previews: some View {
        AddBoxView()
    }
}
