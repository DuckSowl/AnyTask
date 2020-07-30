//
//  UIColor+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 28.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let maskAndScale: (Int) -> CGFloat = { CGFloat($0 & 0xFF) / 255 }
        let red   = maskAndScale(hex >> 16)
        let green = maskAndScale(hex >> 8)
        let blue  = maskAndScale(hex)
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, *) {
            self.init { $0.userInterfaceStyle == .dark ? dark : light }
        } else {
            self.init(cgColor: light.cgColor) 
        }
    }
}
