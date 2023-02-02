//
//  Coordinating.swift
//  CoordinatorKit
//
//  Created by Dal Rupnik on 2/2/23.
//  Copyright © 2023 Blub Blub. All rights reserved.
//

import Foundation

public protocol Coordinating: AnyObject {
    func send(message: CoordinatorMessageable)
}
