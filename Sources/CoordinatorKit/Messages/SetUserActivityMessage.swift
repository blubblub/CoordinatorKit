//
//  SetUserActivityMessage.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 2/2/23.
//  Copyright © 2023 Blub Blub. All rights reserved.
//

import Foundation

public struct SetUserActivityMessage: CoordinatorMessageable {
    public let userActivity: NSUserActivity?
    
    public init(userActivity: NSUserActivity?) {
        self.userActivity = userActivity
    }
}
