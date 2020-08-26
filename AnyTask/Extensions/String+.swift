//
//  String+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 26.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

extension String {
    static func object(_ object: String,
                       shouldBeInRange range: ClosedRange<Int>) -> String {
        "\(object) should be from \(notNil: range.min()) " +
        "to \(notNil: range.max())."
    }
}
