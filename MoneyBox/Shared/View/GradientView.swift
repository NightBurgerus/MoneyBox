//
//  GradientView.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI

struct GradientView: View {
    var body: some View {
        LinearGradient(colors: [AppColors.appBackground, AppColors.darkBlue], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)).edgesIgnoringSafeArea(.all)
    }
}
