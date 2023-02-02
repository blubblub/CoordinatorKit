//
//  CoordinatorComponent.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 2/2/23.
//  Copyright © 2023 Blub Blub. All rights reserved.
//

import Foundation

// TODO: Move this into a coordinator library!
protocol CoordinatorComponentComposable {
    var components: [CoordinatorComponent] { get }
    func add(component: CoordinatorComponent)
    func component<T: CoordinatorComponent>(_ type: T.Type) -> T
}

protocol CoordinatorComponent {
    /// Coordinator should ask component first without destructive action,
    /// if the action can be handled.
    func canHandleMessage(message: CoordinatorMessageable, with coordinator: Coordinator) -> Bool
    
    /// And first component that can handle will call this message
    func handle(message: CoordinatorMessageable, with coordinator: Coordinator)
}
