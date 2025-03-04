//
//  ViewControllerBuilderResult.swift
//  
//
//  Created by Dal Rupnik on 14.09.2023.
//

import Foundation
import UIKit

@MainActor
public struct ViewControllerBuilderResult {
    public let viewController: UIViewController
    public let coordinator: Coordinator?
    
    public init(viewController: UIViewController, coordinator: Coordinator? = nil) {
        self.viewController = viewController
        self.coordinator = coordinator
    }
    
    public init(coordinator: ViewControllerCoordinator & Coordinator) {
        self.viewController = coordinator.rootViewController
        self.coordinator = coordinator
    }
}
