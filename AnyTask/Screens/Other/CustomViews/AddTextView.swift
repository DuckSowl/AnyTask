//
//  AddTextView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 20.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol AddTextDelegate: Delegate {
    func add(text: String?)
}

class AddTextView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: AddTextDelegate?
    
    let maxTextLength: UInt
    
    private var heightConstraint: NSLayoutConstraint?
    
    // MARK: - Subviews
    
    let textField = TextField()
    let addTextButton = Button.with(type: .plus)
    
    // MARK: - Initializers
    
    init(maxTextLength: UInt) {
        self.maxTextLength = maxTextLength
        
        super.init(frame: .zero)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = textField.sizeThatFitsSelf.height
        if let heightConstraint = heightConstraint {
            heightConstraint.constant = height
        } else {
            heightConstraint = pin.height(height).constraints.first
            heightConstraint?.isActive = true
        }
    }
    
    // MARK: - View Configuration
    
    private func configureSubviews() {
        textField.backgroundColor = Color.light
        textField.delegate = self
        
        addTextButton.addTarget(self, action: #selector(addText), for: .touchUpInside)
        addTextButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        print(addTextButton.contentHuggingPriority(for: .horizontal))
        configureConstraints()
    }
    
    private func configureConstraints() {
        textField.pin(super: self)
            .left().topBottom()
            .activate
        
        addTextButton.pin(super: self)
            .after(textField, Layout.spacer).topBottom().right()
            .activate
    }
    
    // MARK: - Actions
    
    @objc private func addText() {
        delegate?.add(text: textField.text)
    }
}

// MARK: - UITextFieldDelegate

extension AddTextView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        (textField.text as NSString?)?
            .replacingCharacters(in: range, with: string)
            .count ?? 0 < maxTextLength
    }
}
