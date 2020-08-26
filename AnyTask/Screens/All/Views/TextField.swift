//
//  TextField.swift
//  AnyTask
//
//  Created by Anton Tolstov on 20.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    // MARK: - Private Properties
    
    private let padding: UIEdgeInsets
    
    // MARK: - Initializers
    
    init(padding: UIEdgeInsets = .init(same: 8), cornerRadius: CGFloat = 8) {
        self.padding = padding
        
        super.init(frame: .zero)
        
        self.set(cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
