//
//  BuildableFlowViewController.swift
//  
//
//  Created by Dal Rupnik on 14.09.2023.
//

import UIKit

open class BuildableFlowCoordinator : BaseComponentCoordinator, FlowCoordinator {
    
    public let builder: ViewControllerBuildable
    
    public let navigationController: UINavigationController
    
    /// Returns true when builder has a describable that it can build.
    public var hasBuildDescribable: Bool {
        return builder.describable(for: self) != nil
    }
    
    public init(window: UIWindow, navigationController: UINavigationController, builder: ViewControllerBuildable) {
        self.builder = builder
        self.navigationController = navigationController
        
        super.init(window: window)
        
        if let coordinatorInitializable = navigationController as? CoordinatorInitializable {
            coordinatorInitializable.parentCoordinator = self
        }
    }
    
    public init(navigationController: UINavigationController, builder: ViewControllerBuildable, parent: Coordinator) {
        self.builder = builder
        self.navigationController = navigationController
        
        super.init(parent: parent)
        
        if let coordinatorInitializable = navigationController as? CoordinatorInitializable {
            coordinatorInitializable.parentCoordinator = self
        }
    }
    
    open override func send(message: CoordinatorMessageable) {
        if let msg = message as? TriggerFlowMessage {
            triggerFlow(animated: msg.animated, type: msg.presentType)
        }
        else if let msg = message as? ReloadMessage {
            let presentType = (msg.metadata as? PresentType) ?? .present
            
            reload(animated: msg.animated, presentType: presentType, options: msg.options)
        }
        else {
            super.send(message: message)
        }
    }
    
    open override func unhandled(message: CoordinatorMessageable) {
        // We can give the message to the parent if components cannot handle it.
        parentCoordinator?.send(message: message)
    }
    
    open func triggerFlow(animated: Bool, type: CoordinatorKit.PresentType) {
        
        // Clean up children if needed.
        removeChildCoordinators()
        
        if let presentedVC = navigationController.presentedViewController {
            presentedVC.dismiss(animated: animated)
        }
        
        guard let describable = builder.describable(for: self) else {
            // If there's nothing more to display, we're done!
            send(message: BasicMessage.done(self))
            
            return
        }
        
        guard let builderResult = builder.build(from: describable, with: self) else {
            //fatalError("No built view controller for describable: \(describable) with: \(self)")
            send(message: BasicMessage.done(self))
            
            return
        }
        
        if let coordinator = builderResult.coordinator {
            add(child: coordinator)
        }
        
        // Pull builder result out
        let viewControllers = [ builderResult.viewController ]
        
        if type == .present {
            print("[Bootstrap]: Presenting flow \(viewControllers)")
            
            navigationController.setViewControllers(viewControllers, animated: animated)
        }
        else {
            // We're dismissing, so we need to insert the view controllers into the array to simulate pop
            var originalViewControllers = navigationController.viewControllers
            
            originalViewControllers.insert(contentsOf: viewControllers, at: 0)
            
            let uniqueControllers = Set(originalViewControllers)
            
            // There's a view controller in there twice.
            if (uniqueControllers.count != originalViewControllers.count) {
                navigationController.setViewControllers(viewControllers, animated: animated)
            }
            else {
                navigationController.setViewControllers(originalViewControllers, animated: false)
                navigationController.setViewControllers(viewControllers, animated: animated)
            }
        }
    }
    
    open func reload(animated: Bool, presentType: PresentType, options: ReloadOptions) {
        
        if options != .ignoreChildren {
            childCoordinators.forEach { child in
                //child.send(message: message)
                
                var animated = true
                
                if let viewCoordinator = child as? ViewControllerCoordinator {
                    animated = viewCoordinator.rootViewController.view?.window != nil
                }
                
                child.send(message: TriggerFlowMessage(animated: animated))
            }
        }
        
        // If there are no child coordinators, send to coordinator directly.
        if options != .onlyChildren {
            let animated = rootViewController.view?.window != nil

            send(message: TriggerFlowMessage(animated: animated))
        }
    }
    
    private func removeChildCoordinators() {
        while !childCoordinators.isEmpty {
            // Because we checked if coordinators are empty, we can force unwrap first. Same as using [0] index.
            remove(child: childCoordinators.first!)
        }
    }
}

extension BuildableFlowCoordinator : ViewControllerCoordinator {
    public var rootViewController: UIViewController {
        return navigationController
    }
}
