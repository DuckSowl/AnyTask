//
//  Array+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 16.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

extension Array {
    func withAppend<S>(contentsOf newElements: S) -> Array where Element == S.Element, S : Sequence {
        return self + newElements
    }
    
    func withAppend(_ newElement: Element) -> Array {
        return self + [newElement]
    }
}
