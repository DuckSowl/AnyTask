//
//  Date+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 21.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

extension Date {
    var formatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: self)
    }
}
