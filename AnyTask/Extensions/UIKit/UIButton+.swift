//
//  UIButton+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 10.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

extension UIButton {
    func withTarget(_ target: Any?, action: Selector,
                    for event: UIControl.Event) -> UIButton {
        addTarget(target, action: action, for: event)
        return self
    }
}
