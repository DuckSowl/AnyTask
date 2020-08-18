//
//  Array+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 16.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

extension Array {
    func withAppend(_ elements: [Element]) -> Array {
        return self + elements
    }
    
    func withAppend(_ elements: Element...) -> Array {
        withAppend(elements)
    }
    
    #if DEBUG
    
    func print() -> Array {
        Swift.print(self)
        return self
    }
    
    #endif
}
