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
    public private(set) var window: UIWindow
    
    public private(set) var childCoordinators: [Coordinator] = []
    
    open func send(message: CoordinatorMessageable) {
        
    }
    
    open func add(child: Coordinator) {
        childCoordinators.append(child)
    }
    
    open func remove(child: Coordinator) {
        childCoordinators.removeAll(where: { $0 === child })
    }
    
    // MARK: - Initialization
    public init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Public Methods
    public func show() {
        window.makeKeyAndVisible()
    }
}
