//
//  DismissibleView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 02.09.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class DismissibleView: UIView {
    
    // MARK: - Properties
    
    let contentView = UIView()
    
    // MARK: - Initializers
        
    init() {
        super.init(frame: .zero)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        backgroundColor = Color.clear
        UIView.animate(withDuration: 0.4) {
            self.backgroundColor = Color.shade
        }
        
        let tap = OnlySelfTapGestureRecognizer(target: self,
                                               action: #selector(dismiss))
        addGestureRecognizer(tap)
    }
    
    // MARK: - Actions
    
    @objc func dismiss() {
        removeFromSuperview()
    }
}
