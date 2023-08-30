//
//  Coordinator.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 2/2/23.
//  Copyright © 2023 Blub Blub. All rights reserved.
//

import Foundation
import UIKit

/// Coordinator protocol
/// Each coordinator should own a UIWindow, and have weak reference to parent Coordinator. Usually the UIWindow would be set up on instantization.
/// Handle any message in send(message: CoordinatorMessageable) method, unhandled should always be sent to parent.
/// While handling message make sure the sender is what you expect, because you might get message from another child Coordinator or UIViewController that you are not aware of.
/// When a child Coordinator is done it should always send a message to it's parent to remove it.
public protocol Coordinator: Coordinating {
    var parentCoordinator: Coordinator? { get set }
    
    var window: UIWindow { get }
    
    // Optionally implement child coordinators.
    var childCoordinators: [Coordinator] { get }
    
    func add(child: Coordinator)
    func remove(child: Coordinator)
}

public extension Coordinator {
    
    var parentCoordinator: Coordinator? {
        return nil
    }
    
    var childCoordinators: [Coordinator] {
        return []
    }
    
    func add(child: Coordinator) {
        
    }
    
    func remove(child: Coordinator) {
        
    }
}

public extension Coordinator {
    func findChild<T: Coordinator>(of type: T.Type) -> T? {
        
        for c in childCoordinators {
            if c is T {
                return c as? T
            }
            
            let result = c.findChild(of: type)
            if result != nil { return result }
        }
        
        return nil
    }
    
    func findParent<T: Coordinator>(of type: T.Type) -> T? {
        // Check if current parent is of type we're looking for.
        if let parent = parentCoordinator as? T {
            return parent
        }
        
        // Propagate parent upwards.
        return parentCoordinator?.findParent(of: type)
    }
}


public extension UIViewController {
    /// First Coordinator in UIViewController chain, starting with self
    var coordinator: Coordinating? {
        if let coordinator = (self as? CoordinatorInitializable)?.parentCoordinator {
            return coordinator
        } else {
            return (parent ?? presentingViewController)?.coordinator
        }
    }
}


/// A Coordinator that exposes view controller, but the window management must be
/// handled by it's parent coordinator
public protocol ViewControllerCoordinator {
    var parentCoordinator: Coordinator? { get }
    
    var rootViewController: UIViewController { get }
}

/// Adds ability to present child coordinators
public extension ViewControllerCoordinator {
    func present(child: Coordinator & ViewControllerCoordinator, animated: Bool) {
        if let selfCoordinator = self as? Coordinator {
            selfCoordinator.add(child: child)
        }
        
        child.rootViewController.modalPresentationStyle = .fullScreen
                
        rootViewController.present(child.rootViewController, animated: animated)
    }
    
    func dismiss(child: Coordinator & ViewControllerCoordinator, animated: Bool) {
        guard let selfCoordinator = self as? Coordinator & ViewControllerCoordinator else {
            return
        }
        
        selfCoordinator.remove(child: child)
        
        if selfCoordinator.rootViewController.presentedViewController === child.rootViewController {
            child.rootViewController.dismiss(animated: animated)
        }
    }
}
