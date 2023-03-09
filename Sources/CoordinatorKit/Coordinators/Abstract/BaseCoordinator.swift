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
    
    open func send(message: CoordinatorMessageable) {
        
    }
    
    // MARK: - Initialization
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Public Methods
    public func show() {
        window.makeKeyAndVisible()
    }
}
