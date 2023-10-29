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

public struct ViewControllerTransition {
    public init(transitionStyle: UIModalTransitionStyle = .coverVertical, modalPresentationStyle: UIModalPresentationStyle = .fullScreen, transitioningDelegate: UIViewControllerTransitioningDelegate? = nil) {
        self.transitionStyle = transitionStyle
        self.modalPresentationStyle = modalPresentationStyle
        self.transitioningDelegate = transitioningDelegate
    }
    
    let transitionStyle: UIModalTransitionStyle
    let modalPresentationStyle: UIModalPresentationStyle
    let transitioningDelegate: UIViewControllerTransitioningDelegate?
}

/// Adds ability to present child coordinators
public extension ViewControllerCoordinator {
    
    /// Presents child coordinator as modal on self directly.
    /// - Parameters:
    ///   - child: view controller coordinator (also coordinator)
    ///   - animated: if it should be animated.
    ///   - transition: if there should be a transition for the animation.
    ///   - completion: called when animation is completed.
    func present(child: ViewControllerCoordinator, animated: Bool, transition: ViewControllerTransition = ViewControllerTransition(), completion: (() -> Void)? = nil) {
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
    func presentInHierarchy(child: ViewControllerCoordinator, animated: Bool, transition: ViewControllerTransition = ViewControllerTransition(), completion: (() -> Void)? = nil) {
        if let childCoordinator = child as? Coordinator, let selfCoordinator = self as? Coordinator {
            selfCoordinator.add(child: childCoordinator)
        }
        
        var currentVC = rootViewController
        
        while currentVC.presentedViewController != nil {
            currentVC = currentVC.presentedViewController!
        }
        
        present(child: child.rootViewController, on: currentVC, animated: animated, transition: transition, completion: completion)
    }
    
    func presentInHierarchy(viewController: UIViewController, animated: Bool, transition: ViewControllerTransition = ViewControllerTransition(), completion: (() -> Void)? = nil) {
        
        var currentVC = rootViewController
        
        while currentVC.presentedViewController != nil {
            currentVC = currentVC.presentedViewController!
        }
        
        present(child: viewController, on: currentVC, animated: animated, transition: transition, completion: completion)
    }
    
    func dismiss(child: ViewControllerCoordinator, animated: Bool, transition: ViewControllerTransition? = nil, completion: (() -> Void)? = nil) {
        if let selfCoordinator = self as? Coordinator, let childCoordinator = child as? Coordinator {
            selfCoordinator.remove(child: childCoordinator)
        }
        
        // If dismiss wants to override the transition.
        if let transition = transition {
            child.rootViewController.modalPresentationStyle = transition.modalPresentationStyle
            
            if animated {
                child.rootViewController.modalTransitionStyle = transition.transitionStyle
                
                if let transitioningDelegate = transition.transitioningDelegate {
                    child.rootViewController.transitioningDelegate = transitioningDelegate
                }
            }
        }
        
        child.rootViewController.dismiss(animated: animated, completion: completion)
    }
        
    private func present(child childVC: UIViewController, on viewController: UIViewController, animated: Bool, transition: ViewControllerTransition = ViewControllerTransition(), completion: (() -> Void)? = nil) {
        
        childVC.modalPresentationStyle = transition.modalPresentationStyle
        
        if animated {
            childVC.modalTransitionStyle = transition.transitionStyle
            if let transitioningDelegate = transition.transitioningDelegate {
                childVC.transitioningDelegate = transitioningDelegate
            }
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
