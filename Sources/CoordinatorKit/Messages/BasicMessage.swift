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
    
    /// Notifies that back action was triggered
    case back(Any)

    // Notifies about skip action (Coordinator should figure out what to do next)
    case skip(Any)
    
    public func copy(with sender: Any) -> BasicMessage {
        switch self {
        case .back:
            return BasicMessage.back(sender)
        case .done:
            return BasicMessage.done(sender)
        case .cancel:
            return BasicMessage.cancel(sender)
        case .skip:
            return BasicMessage.skip(sender)
        }
    }
}

public extension Coordinating {
    func send(message: BasicMessage) {
        send(message: message)
    }
}
