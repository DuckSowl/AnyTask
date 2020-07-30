//
//  AddTaskViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 16.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

enum AddTaskViewModel {
    static let backgroundColor = Color.background
    static let shadeColor = Color.shade
    
    static let titleFont = UIFont
        .preferredFont(forTextStyle: .title3)
        .roundedIfAvailable()
    
    static let smallFont = UIFont
        .preferredFont(forTextStyle: .subheadline)
        .roundedIfAvailable()
    
    static let textColor = UIColor.black
   
    
    static let addButtonText = "Add"
    static let addButtonCornerRadius = CGFloat(10)
    static let addButtonContentEdgeInsets = UIEdgeInsets(same: 5)
    static let cornerRadius = CGFloat(10)
    
    static let secondColor = Color.background
    
    static let textSeparatorAnchor = CGFloat(5)
    static let sideAnchor = CGFloat(15)
    static let topAnchor = CGFloat(15)
    static let bottomAnchor = CGFloat(15)
    
    static let topOffset = CGFloat(50)
}
