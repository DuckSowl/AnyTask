//
//  ButtonFactory.swift
//  AnyTask
//
//  Created by Anton Tolstov on 20.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

enum Button {
    
    // MARK: - Constants
    
    private enum Constants {
        static let addButtonImage = UIImage(named: "plus")!
    }
    
    // MARK: - Factory
    
    static func with(type: ButtonType) -> UIButton {
        switch type {
            case .plus:
                return plusButton
            case .text(let text):
                return button(with: text)
            default:
                print("Not Implemented button!")
                return UIButton()
        }
    }
    
    // MARK: - Private Methods
    
    private static func makeButton() -> UIButton {
        let button = QuaterCornerButton()
        button.tintColor = .white
        
        button.imageView?.pin.aspectRatio(1).activate
        
        return button
    }
    
    private static func makeSquareButton() -> UIButton {
        let button = makeButton()
        
        button.pin.aspectRatio(1).activate
        button.imageView?.heightAnchor
            .constraint(equalTo: button.heightAnchor,
                        multiplier: 0.6).isActive = true
        
        return button
    }
    
    private static var plusButton: UIButton {
        let addButton = makeSquareButton()
        
        // TODO: Rework to Color manager
        addButton.backgroundColor = .red
        
        addButton.setImage(Constants.addButtonImage.template, for: .normal)
                
        return addButton
    }
    
    private static func button(with text: String) -> UIButton {
        let button = makeButton()
        button.setTitle(text, for: .normal)
        return button
    }
    
    // MARK: - Enums
    
    enum ButtonType {
        case plus
        case text(String)
        case pomodoro
    }
}

fileprivate class QuaterCornerButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        set(cornerRadius: bounds.height / 4)
    }
}
