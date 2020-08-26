//
//  OnlySelfTapGestureRecognizer.swift
//  AnyTask
//
//  Created by Anton Tolstov on 12.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class OnlySelfTapGestureRecognizer: UITapGestureRecognizer {
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        
        delegate = self
    }
}

extension OnlySelfTapGestureRecognizer: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}
