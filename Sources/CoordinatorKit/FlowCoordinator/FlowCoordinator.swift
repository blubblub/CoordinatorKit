//
//  FlowCoordinator.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 2/2/23.
//  Copyright © 2023 Blub Blub. All rights reserved.
//

import Foundation
import UIKit

/// A Coordinator that knows how to compute flow based on state.
public protocol FlowCoordinator {
    
    /// Returns view controller based on FlowState
    /// - Parameter state: state of flow.
    /// - Returns: View controller that represents state.
    func viewController(for state: FlowState) -> UIViewController
}
