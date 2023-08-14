//
//  UIKit2SwiftUI.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI

struct IntrospectionPresentation: UIViewControllerRepresentable {
    typealias UIViewControllerType = LifecircleIntrospection
    let completion: (() -> Void)?
    let type: LifecircleType
    
    init(type: LifecircleType, completion: @escaping () -> ()) {
        self.completion = completion
        self.type = type
    }
    
    func makeUIViewController(context: Context) -> LifecircleIntrospection {
        let vc = LifecircleIntrospection(completion: completion, type: type)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: LifecircleIntrospection, context: Context) {
    }
}

struct IntrospectionNavigationControllerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = IntrospectionNavigationController
    let completion: ((UINavigationController?) -> Void)
    
    init(completion: @escaping((UINavigationController?) -> Void)) {
        self.completion = completion
    }
    
    func makeUIViewController(context: Context) -> IntrospectionNavigationController {
        let vc = IntrospectionNavigationController(completion: completion)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: IntrospectionNavigationController, context: Context) {
    }
}
