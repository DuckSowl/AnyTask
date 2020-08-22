//
//  StringInterpolation+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 22.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

extension String.StringInterpolation {
    mutating func appendInterpolation<T>(notNil object: T?,
                                         else: String = "")
        where T: CustomStringConvertible {
            appendLiteral(object != nil ? "\(object!)" : `else`)
    }
}
