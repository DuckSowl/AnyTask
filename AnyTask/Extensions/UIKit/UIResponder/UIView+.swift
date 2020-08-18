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
    func set(cornerRadius: CGFloat, for corners: [Corner] = [.all]) {
        if #available(iOS 11.0, *) {
            layer.maskedCorners = corners.mask
            layer.cornerRadius = cornerRadius
        } else {
            // Add corners for iOS 10
        }
    }
    
    func set(cornerRadius: CGFloat, for corners: Corner...) {
        set(cornerRadius: cornerRadius, for: corners)
    }
    
    
    func with(backgroundColor: UIColor) -> UIView {
        self.backgroundColor = backgroundColor
        return self
    }
    
    func with(contentMode: ContentMode) -> UIView {
        self.contentMode = contentMode
        return self
    }
    
    func `as`<UIView>(_: UIView.Type) -> UIView {
        self as! UIView
    }
    
    
    // TODO: - Move to Little Pin
    func unpin() -> Pin {
        self.pin.unpin()
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
