//
//  CoordinatorInitializable.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 2/2/23.
//  Copyright © 2023 Blub Blub. All rights reserved.
//

import Foundation

/// UIViewControllers that are owned by Coordinator should implement this and hold a weak reference to their Coordinator
public protocol CoordinatorInitializable: AnyObject {
    var parentCoordinator: Coordinating? { get }
}
