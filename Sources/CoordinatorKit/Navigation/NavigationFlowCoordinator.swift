//
//  NavigationFlowCoordinator.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 3/9/23.
//  Copyright © 2023 Blub Blub Inc. All rights reserved.
//

import Foundation
import UIKit

public struct TriggerFlowMessage: CoordinatorMessageable {
    public var animated = true
    public var presentType: PresentType = .present
    
    public init(animated: Bool = true, presentType: PresentType = .present) {
        self.animated = animated
        self.presentType = presentType
    }
}

open class NavigationFlowCoordinator : BaseComponentCoordinator, FlowCoordinator {
    public private(set) var navigationController: UINavigationController
    public private(set) var flow: FlowPresentable
    
    
    // MARK: - Initialization
    public init(window: UIWindow, navigationController: UINavigationController, flow: FlowPresentable) {
        self.navigationController = navigationController
        self.flow = flow
        
        super.init(window: window)
    }
    
    open override func unhandled(message: CoordinatorMessageable) {
        if let msg = message as? TriggerFlowMessage {
            triggerFlow(animated: msg.animated, type: msg.presentType)
            return
        }
        
        super.unhandled(message: message)
    }
    
    // MARK: - FlowCoordinator
    open func computeState() -> FlowState? {
        fatalError("Compute State needs to be defined")
    }
    
    public func triggerFlow(animated: Bool, type: PresentType) {
        guard let state = computeState() else {
            fatalError("No flow state available, required to proceed")
        }
        
        let viewControllers = flow.viewControllers(for: state)
        
        if type == .present {
            navigationController.setViewControllers(viewControllers, animated: animated)
        }
        else {
            // We're dismissing, so we need to insert the view controllers into the array to simulate pop
            var originalViewControllers = navigationController.viewControllers
            originalViewControllers.insert(contentsOf: viewControllers, at: 0)

            navigationController.setViewControllers(originalViewControllers, animated: false)
            navigationController.setViewControllers(viewControllers, animated: animated)
        }
    }
}
