//
//  NSLayoutConstraints+Helpers.swift
//  AnyTask
//
//  Created by Anton Tolstov on 09.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    class func activateFrom(insets: UIEdgeInsets, subview: UIView, superview: UIView) {
        activate([
            subview.topAnchor.constraint(equalTo: superview.topAnchor,
                                         constant: insets.top),
            subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor,
                                             constant: insets.leading),
            subview.trailingAnchor.constraint(equalTo: superview.trailingAnchor,
                                              constant: insets.trailing),
            subview.bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                            constant: insets.bottom)
        ])
    }
}

extension UIEdgeInsets {
    init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        self.init(top: top, left: leading, bottom: bottom, right: trailing)
    }
    
    static let zero = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    fileprivate var leading: CGFloat { left }
    fileprivate var trailing: CGFloat { right }
}
