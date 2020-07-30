//
//  TabBarButtonViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 02.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol TabBarButtonViewModel {
    var icon: UIImage? { get }
    var iconSize: CGSize { get }
    var iconColor: UIColor { get }
    var iconSelectedColor: UIColor { get }

    var backgroundColor: UIColor? { get }
    var cornerRadius: CGFloat { get }
}

extension TabBarButtonViewModel {
    var basePath: String { "tabbar-icon" }
    
    var iconColor: UIColor { Color.light }
    var iconSelectedColor: UIColor { Color.dark }
    var cornerRadius: CGFloat { iconSize.height / 2 }
}
