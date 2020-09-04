//
//  Color.swift
//  AnyTask
//
//  Created by Anton Tolstov on 28.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

enum Color {
    
    static let white = 0xF5F5FA.color
    
    static let light = UIColor(light: white,
                                dark: 0x000000.color)
        
    static let gray = UIColor(light: 0xE2E2E9.color,
                               dark: 0x1C1C1E.color)
        
    static let darkGray = UIColor(light: 0xD3D3DC.color,
                                   dark: 0x2C2C2E.color)
    
    static let alwaysDark = 0x3A3A3C.color
    
    static let dark = UIColor(light: alwaysDark,
                               dark: white)
    
    static let red = UIColor(light: 0xD60020.color,
                              dark: 0xA30018.color)
    
    static let green = UIColor(light: 0x208175.color,
                                dark: 0x208175.color)
    
    static let contrast = UIColor(light: 0x555555.color,
                                   dark: 0x777777.color)
    
    static let shade = UIColor(light: 0x000000.color(alpha: 0.3),
                                dark: 0x000000.color(alpha: 0.6))
    
    static let clear = UIColor.clear
    
    static var random: UIColor {
        .init(red: CGFloat.random(in: 0.2...0.8),
              green: CGFloat.random(in: 0.2...0.8),
              blue: CGFloat.random(in: 0.2...0.8),
              alpha: 1)
    }
}
