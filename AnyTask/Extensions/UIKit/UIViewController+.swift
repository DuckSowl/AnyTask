//
//  UIViewController+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        insert(child, at: view.subviews.endIndex, frame: frame)
    }
    
    func insert(_ child: UIViewController, at index: Int, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.insertSubview(child.view, at: index)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    
    #if DEBUG
    
    func notImplementedAlert() {
        let alert = UIAlertController(title: "Not implemented!", message: nil,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    #endif
}
