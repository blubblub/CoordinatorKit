//
//  FlowCoordinator.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 2/2/23.
//  Copyright © 2023 Blub Blub. All rights reserved.
//

import Foundation
import UIKit

public enum PresentType {
    case present
    case dismiss
}

/// A Coordinator that knows how to compute flow based on state.
public protocol FlowCoordinator {
    func triggerFlow(animated: Bool, type: PresentType)
}

public extension FlowCoordinator {
    func presentFlow(animated: Bool) {
        triggerFlow(animated: animated, type: .present)
    }
    
    func dismissFlow(animated: Bool) {
        triggerFlow(animated: animated, type: .dismiss)
    }
}
