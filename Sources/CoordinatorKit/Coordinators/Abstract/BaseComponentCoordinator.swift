//
//  BaseComponentCoordinator.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 3/9/23.
//  Copyright © 2023 Blub Blub Inc. All rights reserved.
//

import Foundation
import UIKit

@MainActor
open class BaseComponentCoordinator: BaseCoordinator, CoordinatorComponentComposable {
    
    // MARK: - CoordinatorComponentComposable
    public private(set) var components: [CoordinatorComponent] = []
    
    public func add(component: CoordinatorComponent) {
        components.append(component)
    }
    
    public func component<T: CoordinatorComponent>(_ type: T.Type) -> T {
        return components.first(where: { component in component is T }) as! T
    }
    
    // MARK: - Coordinator
    
    open override func send(message: CoordinatorMessageable) {
        //
        // First ask all components, if one can handle the message.
        //

        for component in components where component.canHandleMessage(message: message, with: self) {
            component.handle(message: message, with: self)
            return
        }
        
        unhandled(message: message)
    }
    
    open func unhandled(message: CoordinatorMessageable) {
        print("Unhandled message: \(message)")
    }
}

// Parent chain component support
@MainActor
public extension Coordinator {
    func findComponent<T: CoordinatorComponent>(of type: T.Type) -> T? {
        if let selfComponentComposable = self as? CoordinatorComponentComposable {
            // Check if we have the component, otherwise, go to the parent.
            if let component = selfComponentComposable.components.first(where: { component in component is T }) as? T {
                return component
            }
        }
        
        return parentCoordinator?.findComponent(of: type)
    }
}
