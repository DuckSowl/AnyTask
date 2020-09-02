//
//  NavigationBarViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 03.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit
import Pin

class TopBarView: UIView {
    
    // MARK: - Constants
    
    enum Constants {
        static let buttonHeight: CGFloat = 24
        static let horizontalSpacing: CGFloat = 20
        
        static let searchImage = UIImage(named: "search")
    }
    
    let contentHeight: CGFloat = 48
    
    // MARK: - Subviews
    
    let contentView = UIView()
    
    let rightButtonsStack: UIStackView = {
        let rightButtonsStack = UIStackView()
        rightButtonsStack.spacing = Constants.horizontalSpacing
        return rightButtonsStack
    }()
    
    let searchButton =
        button(with: Constants.searchImage)
            .withTarget(self, action: #selector(search), for: .touchUpInside)
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func configureSubviews() {
        set(cornerRadius: .large, for: [.bottom])
        clipsToBounds = true
        
        backgroundColor = Color.darkGray
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        contentView.pin(super: self)
            .allSafe().height(contentHeight).activate
        
        rightButtonsStack
            .pin(super: contentView)
            .vCenter().height(Constants.buttonHeight)
            .right(Constants.horizontalSpacing)
            .activate
        
        searchButton
            .pin(super: contentView)
            .vCenter().height(Constants.buttonHeight)
            .before(rightButtonsStack, 20)
            .aspectRatio(1)
            .activate
    }
    
    static func button(with image: UIImage?) -> UIButton {
        let button = UIButton()
        button.setImage(image?.template, for: .normal)
        button.tintColor = Color.dark
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    // MARK: - Actions
    
    @objc private func search() { showNotImplementedAlert() }
}
