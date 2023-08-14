//
//  CircleAttributes.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI

struct CircleAttributes {
    let currentValue: Double
    let finishValue: Double
    let step: Double
    let width: CGFloat
    let height: CGFloat
    let circleColor: Color
    let finishColor: Color
    
    init(value: Double, finishValue: Double, step: Double) {
        self.currentValue = value
        self.finishValue = finishValue
        self.step = step
        self.width = Const.bounds.width * 4/5
        self.height = Const.bounds.width * 4/5
        self.circleColor = Color.blue
        self.finishColor = Color.yellow
    }
    
    init(value: Double,
         finishValue: Double,
         step: Double,
         width: CGFloat,
         height: CGFloat,
         circleColor: Color,
         finishColor: Color) {
        self.currentValue = value
        self.finishValue = finishValue
        self.step = step
        self.width = width
        self.height = height
        self.circleColor = circleColor
        self.finishColor = finishColor
    }
}
