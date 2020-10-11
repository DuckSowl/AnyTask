//
//  FontManager.swift
//  AnyTask
//
//  Created by Anton Tolstov on 01.09.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

enum Font {
    static let large = UIFont
        .systemFont(ofSize: 40)
        .roundedIfAvailable()
    
    static let title = UIFont
        .preferredFont(forTextStyle: .title1)
        .roundedIfAvailable()
    
    static let subtitle = UIFont
        .preferredFont(forTextStyle: .title3)
        .roundedIfAvailable()
    
    static let body = UIFont
        .preferredFont(forTextStyle: .subheadline)
        .roundedIfAvailable()
}
