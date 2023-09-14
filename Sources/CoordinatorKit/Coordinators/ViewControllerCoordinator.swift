//
//  ViewControllerBuildable.swift
//
//
//  Created by Dal Rupnik on 14.09.2023.
//

import UIKit

/// A Coordinator that exposes view controller, but the window management must be
/// handled by it's parent coordinator
public protocol ViewControllerCoordinator {
    var parentCoordinator: Coordinator? { get }
    
    var rootViewController: UIViewController { get }
}

/// Adds ability to present child coordinators
public extension ViewControllerCoordinator {
    
    /// Presents child coordinator as modal on self directly.
    /// - Parameters:
    ///   - child: view controller coordinator (also coordinator)
    ///   - animated: if it should be animated.
    ///   - transition: if there should be a transition for the animation.
    ///   - completion: called when animation is completed.
    func present(child: ViewControllerCoordinator, animated: Bool, transition: UIModalTransitionStyle = .coverVertical, completion: (() -> Void)? = nil) {
        if let childCoordinator = child as? Coordinator, let selfCoordinator = self as? Coordinator {
            selfCoordinator.add(child: childCoordinator)
        }
        
        present(child: child.rootViewController, on: rootViewController, animated: animated, transition: transition, completion: completion)
    }
    
    /// Similar as Present above, but it will modally present it on the lowest presented VC.
    /// It will interatively loop until on currently owned VC, until is no more presented VC.
    /// The last active VC will present the controller.
    /// - Parameters:
    ///   - child: view controller coordinator (also coordinator)
    ///   - animated: if it should be animated.
    ///   - transition: if there should be a transition for the animation.
    ///   - completion: called when animation is completed.
    func presentInHierarchy(child: ViewControllerCoordinator, animated: Bool, transition: UIModalTransitionStyle = .coverVertical, completion: (() -> Void)? = nil) {
        if let childCoordinator = child as? Coordinator, let selfCoordinator = self as? Coordinator {
            selfCoordinator.add(child: childCoordinator)
        }
        
        var currentVC = rootViewController
        
        while currentVC.presentedViewController != nil {
            currentVC = currentVC.presentedViewController!
        }
        
        present(child: child.rootViewController, on: currentVC, animated: animated, transition: transition, completion: completion)
    }
    
    func presentInHierarchy(viewController: UIViewController, animated: Bool, transition: UIModalTransitionStyle = .coverVertical, completion: (() -> Void)? = nil) {
        
        var currentVC = rootViewController
        
        while currentVC.presentedViewController != nil {
            currentVC = currentVC.presentedViewController!
        }
        
        present(child: viewController, on: currentVC, animated: animated, transition: transition, completion: completion)
    }
    
    func dismiss(child: ViewControllerCoordinator, animated: Bool, completion: (() -> Void)? = nil) {
        if let selfCoordinator = self as? Coordinator, let childCoordinator = child as? Coordinator {
            selfCoordinator.remove(child: childCoordinator)
        }
        
        child.rootViewController.dismiss(animated: animated, completion: completion)
    }
    
    
    private func present(child childVC: UIViewController, on viewController: UIViewController, animated: Bool, transition: UIModalTransitionStyle = .coverVertical, completion: (() -> Void)? = nil) {
        
        childVC.modalPresentationStyle = .fullScreen
        
        if animated {
            childVC.modalTransitionStyle = transition
        }
        
        viewController.present(childVC, animated: animated)
    }
}

public extension Coordinator {
    func triggerFlowInChildren() {
        // Send the success message through all children.
        childCoordinators.forEach { child in
            //child.send(message: message)
            
            var animated = true
            
            if let viewCoordinator = child as? ViewControllerCoordinator {
                animated = viewCoordinator.rootViewController.view?.window != nil
            }
                               
            child.send(message: TriggerFlowMessage(animated: animated))
        }
        
        // If there are no child coordinators, send to coordinator directly.
        if childCoordinators.isEmpty {
            var animated = true
            
            if let viewCoordinator = self as? ViewControllerCoordinator {
                animated = viewCoordinator.rootViewController.view?.window != nil
            }
            
            send(message: TriggerFlowMessage(animated: animated))
        }
    }
}
