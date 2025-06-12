//
//  ReloadMessage.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 9/5/23.
//  Copyright © 2023 Blub Blub. All rights reserved.
//

public enum ReloadOptions {
    case all
    case onlyChildren
    case ignoreChildren
}

/// Once Coordinator receives this message, it should reload based on options
@MainActor
public struct ReloadMessage : CoordinatorMessageable {
    public var animated = true
    public var options = ReloadOptions.ignoreChildren
    public var metadata: Any? = nil
    
    public init(animated: Bool = true, options: ReloadOptions = ReloadOptions.all, metadata: Any? = nil) {
        self.animated = animated
        self.options = options
        self.metadata = metadata
    }
}
