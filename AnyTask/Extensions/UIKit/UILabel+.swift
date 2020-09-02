//
//  UILabel+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 01.09.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String? = nil, font: UIFont? = nil) {
        self.init()
        
        self.text = text
        if let font = font { self.font = font }
    }
}
