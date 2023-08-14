//
//  CircleView.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI
import AudioToolbox

struct CircleProgress: View {
    private let attributes: CircleAttributes
    private let animationDuration = 1.0
    @State private var trimFrom: CGFloat = 0.0
    @State private var trimTo: CGFloat = 0.0
    @State private var trimFinishFrom: CGFloat = 0.0
    @State private var trimFinishTo: CGFloat = 0.0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var progress: Double = 0.0
    @State private var currentValue: Double = 0.0
    @State private var taskFinished = false
    @State private var scaleSize = CGSize(width: 1.0, height: 1.0)
    
    init(attributes: CircleAttributes) {
        self.attributes = attributes
    }
    
    var body: some View {
        ZStack {
            circle
            circleText
            
            if taskFinished {
                finishedCircle
            }
        }
        .frame(width: attributes.width, height: attributes.height)
        .viewDidLoad {
            DispatchQueue.main.async {
                configureView()
            }
        }
        .onChange(of: progress) { newProgress in
            taskFinished = newProgress >= 100.0
        }
    }
    
    private func configureView() {
        taskFinished = attributes.currentValue >= attributes.finishValue
        withAnimation(.easeInOut(duration: animationDuration)) {
            currentValue = attributes.currentValue
            progress = (currentValue * 100).rounded() / attributes.finishValue
            trimTo = progress / 100
        }
    }
}

extension CircleProgress {
    private var circle: some View {
        Circle()
            .fill(attributes.circleColor)
            .mask(
                Circle()
                    .trim(from: trimFrom, to: trimTo)
                    .stroke(style: StrokeStyle(lineWidth: 25, lineCap: .round, lineJoin: .miter))
                    .rotationEffect(.degrees(-90))
            )
            .onReceive(timer) { _ in
                if taskFinished {
                    
                    return
                }
                withAnimation(.linear(duration: animationDuration)) {
                    currentValue += attributes.step
                    progress = (currentValue * 100).rounded() / attributes.finishValue
                    trimTo = progress / 100
                }
            }
            .scaleEffect(scaleSize)
    }
    
    private var finishedCircle: some View {
        Circle()
            .fill(attributes.finishColor)
            .mask(
                Circle()
                    .trim(from: trimFinishFrom, to: trimFinishTo)
                    .stroke(style: StrokeStyle(lineWidth: 25, lineCap: .round, lineJoin: .miter))
                    .rotationEffect(.degrees(-90))
            )
            .onAppear {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    trimFinishTo = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                    withAnimation(.easeIn(duration: animationDuration / 8)) {
                        scaleSize = CGSize(width: 1.1, height: 1.1)
                        vibrate()
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 1.125) {
                    withAnimation(.easeIn(duration: animationDuration / 8)) {
                        scaleSize = CGSize(width: 1.0, height: 1.0)
                        vibrate()
                    }
                }
                
            }
            .scaleEffect(scaleSize)
    }
    
    private var circleText: some View {
        VStack {
            Text(String(format: "%.2f", currentValue))
                .foregroundColor(.white)
                .frame(width: Const.bounds.width)
            Text(String(format: "%.2f", progress) + "%")
                .foregroundColor(.white)
                .frame(width: Const.bounds.width)
        }
        
    }
    
    private func vibrate() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}
