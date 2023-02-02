//
//  BasicMessage.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 2/2/23.
//  Copyright © 2023 Blub Blub. All rights reserved.
//

import Foundation

/// BasicMessage that includes sender
public enum BasicMessage: CoordinatorMessageable {
    /// Notifies that you are done with your work (Coordinator should figure out what to do next)
    case done(Any)
    /// Notifies that you cancelled without completing your work (Coordinator should figure out what to do next)
    case cancel(Any)
}

public extension Coordinating {
    func send(message: BasicMessage) {
        send(message: message)
    }
}
