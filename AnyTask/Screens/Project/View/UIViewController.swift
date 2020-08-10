//
//  UIViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 04.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

#if DEBUG

extension UIViewController {
    func notImplementedAlert() {
        let alert = UIAlertController(title: "Not implemented!", message: nil,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
}

#endif
