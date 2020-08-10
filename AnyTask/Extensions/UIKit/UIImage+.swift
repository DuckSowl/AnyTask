//
//  UIImage+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 10.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

extension UIImage {
    var original: UIImage {
        self.withRenderingMode(.alwaysOriginal)
    }
    
    var template: UIImage {
        self.withRenderingMode(.alwaysTemplate)
    }
}


