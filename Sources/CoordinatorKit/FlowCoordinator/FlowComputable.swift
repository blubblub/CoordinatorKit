//
//  FlowComputable.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 2/2/23.
//  Copyright © 2023 Blub Blub. All rights reserved.
//

import Foundation
import UIKit

/// Compute view controller based on state
public protocol FlowComputable {
    
    /// Returns view controller based on FlowState
    /// - Parameter state: state of flow.
    /// - Returns: View controller that represents state.
    func viewController(for state: FlowState) -> UIViewController
}
