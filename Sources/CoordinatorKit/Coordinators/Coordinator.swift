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
/// Each coordinator should own a UIViewController, and have weak reference to parent Coordinator.
/// Handle any message in send(message: CoordinatorMessageable) method, unhandled should always be sent to parent.
/// While handling message make sure the sender is what you expect, because you might get message from another child Coordinator or UIViewController that you are not aware of.
/// When a child Coordinator is done it should always send a message to it's parent to remove it.
public protocol Coordinator: Coordinating {
    var parentCoordinator: Coordinator? { get }
    var rootViewController: UIViewController { get }
}

extension UIViewController {
    /// First Coordinator in UIViewController chain, starting with self
    public var coordinator: Coordinating? {
        if let coordinator = (self as? CoordinatorInitializable)?.parentCoordinator {
            return coordinator
        } else {
            return (parent ?? presentingViewController)?.coordinator
        }
    }
}
