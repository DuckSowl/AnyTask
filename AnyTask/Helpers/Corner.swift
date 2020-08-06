//
//  Corner.swift
//  AnyTask
//
//  Created by Anton Tolstov on 03.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

enum Corner {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    
    fileprivate var mask: CACornerMask {
        switch self {
        case .topLeft: return .layerMinXMinYCorner
        case .topRight: return .layerMaxXMinYCorner
        case .bottomLeft: return .layerMinXMaxYCorner
        case .bottomRight: return .layerMaxXMaxYCorner
        }
    }
}

extension Array where Element == Corner {
    var mask: CACornerMask {
        .init(self.map { $0.mask })
    }
}
