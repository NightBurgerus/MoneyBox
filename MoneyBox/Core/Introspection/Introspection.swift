//
//  Introspection.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import UIKit

enum LifecircleType {
    case viewDidLoad, viewWillAppear
    case viewWillLayoutSubview, viewDidLayoutSubviews
    case viewDidAppear
    case viewWillDisappear, viewDidDisappear
}

class LifecircleIntrospection: UIViewController {
    let completion: (() -> Void)?
    let type: LifecircleType
    
    init(completion: (() -> Void)?, type: LifecircleType) {
        self.completion = completion
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == .viewDidLoad { completion?() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if type == .viewWillAppear { completion?() }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if type == .viewWillLayoutSubview { completion?() }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if type == .viewDidLayoutSubviews { completion?() }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if type == .viewDidAppear { completion?() }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if type == .viewWillDisappear { completion?() }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if type == .viewDidDisappear { completion?() }
    }
}

class IntrospectionNavigationController: UIViewController {
    let completion: ((UINavigationController?) -> Void)?
    
    init(completion: @escaping((UINavigationController?) -> Void)) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        completion?(navigationController)
    }
}
