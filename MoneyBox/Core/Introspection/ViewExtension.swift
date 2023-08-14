//
//  ViewExtension.swift
//  MoneyBox
//
//  Created by Чебупелина on 14.08.2023.
//

import SwiftUI

extension View {
    func viewDidLoad(_ perform: @escaping () -> ()) -> some View {
        self.background(IntrospectionPresentation(type: .viewDidLoad, completion: perform))
    }
    
    func viewWillAppear(_ perform: @escaping () -> ()) -> some View {
        self.background(IntrospectionPresentation(type: .viewWillAppear, completion: perform))
    }
    
    func viewWillLayoutSubviews(_ perform: @escaping () -> ()) -> some View {
        self.background(IntrospectionPresentation(type: .viewWillLayoutSubview, completion: perform))
    }
    
    func viewDidLayoutSubviews(_ perform: @escaping () -> ()) -> some View {
        self.background(IntrospectionPresentation(type: .viewDidLayoutSubviews, completion: perform))
    }
    
    func viewDidAppear(_ perform: @escaping () -> ()) -> some View {
        self.background(IntrospectionPresentation(type: .viewDidAppear, completion: perform))
    }
    
    func viewWillDisappear(_ perform: @escaping () -> ()) -> some View {
        self.background(IntrospectionPresentation(type: .viewWillDisappear, completion: perform))
    }
    
    func viewDidDisappear(_ perform: @escaping () -> ()) -> some View {
        self.background(IntrospectionPresentation(type: .viewDidDisappear, completion: perform))
    }
    
    func introspectNavigationController(_ customize: @escaping((UINavigationController?) -> Void)) -> some View {
        self.background(IntrospectionNavigationControllerView(completion: customize))
    }
}
