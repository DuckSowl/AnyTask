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
    case left
    case right
    case top
    case bottom
    
    fileprivate var mask: CACornerMask {
        switch self {
        case .topLeft: return .layerMinXMinYCorner
        case .topRight: return .layerMaxXMinYCorner
        case .bottomLeft: return .layerMinXMaxYCorner
        case .bottomRight: return .layerMaxXMaxYCorner
            
        case .left: return [Corner.topLeft, .bottomLeft].mask
        case .right: return [Corner.topRight, .bottomRight].mask
            
        case .top: return [Corner.topLeft, .topRight].mask
        case .bottom: return [Corner.bottomLeft, .bottomRight].mask
        }
    }
}

extension Array where Element == Corner {
    var mask: CACornerMask {
        .init(self.map { $0.mask })
    }
}
