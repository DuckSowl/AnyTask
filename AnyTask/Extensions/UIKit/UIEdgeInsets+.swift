//
//  UIEdgeInsets+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 09.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    init(same value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal,
                  bottom: vertical, right: horizontal)
    }
}
