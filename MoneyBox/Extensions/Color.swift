//
//  Color.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI

extension Color {
    init(red: Int, green: Int, blue: Int, opacity: Double) {
        self.init(UIColor(red: Double(red) / 255, green: Double(green) / 255, blue: Double(blue) / 255, alpha: opacity))
    }
}
