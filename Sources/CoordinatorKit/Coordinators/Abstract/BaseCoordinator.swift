//
//  BaseCoordinator.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 3/9/23.
//  Copyright © 2023 Blub Blub. All rights reserved.
//

import Foundation
import UIKit

open class BaseCoordinator: NSObject, Coordinator {
    
    // MARK: - Coordinator
    public weak var parentCoordinator: Coordinator?
    
    open var window: UIWindow
    
    public private(set) var childCoordinators: [Coordinator] = []
    
    open func send(message: CoordinatorMessageable) {
        
    }
    
    open func add(child: Coordinator) {
        guard child !== self else {
            fatalError("Cannot add yourself as a child.")
        }        
        childCoordinators.append(child)
        
        child.parentCoordinator = self
    }
    
    open func remove(child: Coordinator) {
        guard child !== self else {
            fatalError("Cannot remove yourself as a child.")
        }
        
        childCoordinators.removeAll(where: { $0 === child })
        
        child.parentCoordinator = nil
    }
    
    // MARK: - Initialization
    public init(window: UIWindow, parent: Coordinator? = nil) {
        self.window = window
        self.parentCoordinator = parent
    }
    
    public init(parent: Coordinator) {
        self.window = parent.window
        self.parentCoordinator = parent
    }
    
    // MARK: - Public Methods
    public func show() {
        window.makeKeyAndVisible()
    }
}
