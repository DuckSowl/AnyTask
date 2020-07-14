//
//  UIFont+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 14.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

extension UIFont {
    func roundedIfAvailable() -> UIFont {
        if #available(iOS 13, *) {
            let fontDescriptor = self.fontDescriptor.withDesign(.rounded)!
            return UIFont(descriptor: fontDescriptor, size: pointSize)
        } else {
            return self
        }
    }
}
