//
//  CornerRadius.swift
//  AnyTask
//
//  Created by Anton Tolstov on 02.09.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

enum CornerRadius {
    static let small  = Cases.small.rawValue
    static let medium = Cases.medium.rawValue
    static let large  = Cases.large.rawValue
    
    enum Cases: CGFloat {
        case small  = 8
        case medium = 16
        case large  = 24
    }
}
