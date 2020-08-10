//
//  VerticalInsets.swift
//  AnyTask
//
//  Created by Anton Tolstov on 10.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

struct VerticalInsets {
    let top: CGFloat
    let bottom: CGFloat
}

func +(insets: VerticalInsets, constant: CGFloat) -> VerticalInsets {
    return VerticalInsets(top: insets.top + constant,
                          bottom: insets.bottom + constant)
}
