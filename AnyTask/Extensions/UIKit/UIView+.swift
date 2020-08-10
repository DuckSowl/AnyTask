//
//  UIView+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 03.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit
import Pin

extension UIView {
    func setCorner(radius: CGFloat, for corners: [Corner]) {
        if #available(iOS 11.0, *) {
            layer.maskedCorners = corners.mask
            layer.cornerRadius = radius
        } else {
            // Add corners for iOS 10
        }
    }
    
    func withBackgroundColor(_ color: UIColor) -> UIView {
        self.backgroundColor = color
        return self
    }
    
    // TODO: - Move to Little Pin
    func pin(superView: UIView) -> Pin {
        if !self.isDescendant(of: superView) {
            superView.addSubview(self)
        }
        
        return self.pin
    }
    
    #if DEBUG
    
    func notImplementedAlert() {
        UIApplication
            .shared.windows.first?
            .rootViewController?
            .notImplementedAlert()
    }
    
    #endif
}
