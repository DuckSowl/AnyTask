//
//  Int+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 28.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

extension Int {
    var color: UIColor {
        .init(hex: self)
    }
    
    func color(alpha: CGFloat) -> UIColor {
        .init(hex: self, alpha: alpha)
    }
}
