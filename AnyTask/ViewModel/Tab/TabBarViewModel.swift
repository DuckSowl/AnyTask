//
//  TabBarViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 02.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

enum TabBarViewModel {
    static let backgroundColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
    static let cornerRadius = CGFloat(18)
    static let sideAnchor = CGFloat(30)
    static let addButtonOffset = CGFloat(8)
    // Fix for iPhones with and without cornered edges
    static let heightAnchor = CGFloat(85)
}