//
//  UIView+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 03.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

extension UIView {
    func setCorner(radius: CGFloat, for corners: [Corner]) {
        if #available(iOS 11.0, *) {
            layer.maskedCorners = corners.mask
            layer.cornerRadius = radius
        } else {
            // Add corners for iOS 10
        }
    }
}
