//
//  Color.swift
//  AnyTask
//
//  Created by Anton Tolstov on 28.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

enum Color {
    static let background = UIColor(light: 0xF5F5F5.color,
                                     dark: 0x252525.color)
    
    static let light = UIColor(light: 0xFFFFFF.color,
                                dark: 0x111111.color)
    
    static let dark = UIColor(light: 0x111111.color,
                               dark: 0xFFFFFF.color)
    
    static let gray = UIColor(light: 0x3E9483.color,
                               dark: 0x404040.color)
    
    static let shade = 0x000000.color(alpha: 0.2)
    
    static let clear = UIColor.clear
    
    static var random: UIColor {
        .init(red: CGFloat.random(in: 0.2...0.8),
              green: CGFloat.random(in: 0.2...0.8),
              blue: CGFloat.random(in: 0.2...0.8),
              alpha: 1)
    }
}
