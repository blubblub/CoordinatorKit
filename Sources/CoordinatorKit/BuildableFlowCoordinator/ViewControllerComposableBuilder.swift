//
//  ViewControllerComposableBuilder.swift
//  
//
//  Created by Dal Rupnik on 14.09.2023.
//

import Foundation

open class ViewControllerComposableBuilder : ViewControllerBuildable {
    open var builders: [ViewControllerBuildable] = []
    
    public init() {
        
    }
    
    open func build(from description: ViewControllerBuildDescribable, with coordinator: Coordinator) -> ViewControllerBuilderResult? {
        
        for builder in builders {
            guard let result = builder.build(from: description, with: coordinator) else {
                continue
            }
            
            return result
        }
        
        return nil
    }
    
    open func describable(for coordinator: Coordinator) -> ViewControllerBuildDescribable? {
        for builder in builders {
            print("[Bootstrap]: Asking \(builder) for describable.")
            guard let result = builder.describable(for: coordinator) else {
                continue
            }
            
            print("[Bootstrap]: \(builder) returned describable: \(result)")
            
            return result
        }
        
        return nil
    }
}
