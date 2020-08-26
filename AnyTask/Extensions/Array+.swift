//
//  Array+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 16.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

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

extension Array where Element == UIView {
    func sizeThatFitsSelf() -> [CGSize] {
        map { $0.sizeThatFitsSelf }
    }
}

extension Array where Element: Numeric {
    func sum() -> Element {
        self.reduce(0, +)
    }
}

