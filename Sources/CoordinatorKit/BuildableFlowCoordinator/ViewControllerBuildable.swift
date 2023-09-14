//
//  ViewControllerBuildable.swift
//  
//
//  Created by Dal Rupnik on 14.09.2023.
//

import UIKit

public protocol ViewControllerBuildDescribable {
    
}

public protocol ViewControllerBuildable : AnyObject {
    func build(from description: ViewControllerBuildDescribable, with coordinator: Coordinator) -> ViewControllerBuilderResult?
    
    func describable(for coordinator: Coordinator) -> ViewControllerBuildDescribable?
}

public extension ViewControllerBuildable {
    func describable(for coordinator: Coordinator) -> ViewControllerBuildDescribable? {
        return nil
    }
}
