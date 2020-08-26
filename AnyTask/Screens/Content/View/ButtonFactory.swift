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
        static let plusImage = UIImage(named: "plus")!
        static let pomodoroImage = UIImage(named: "pomodoro")!
    }
    
    // MARK: - Factory
    
    static func with(type: ButtonType) -> UIButton {
        switch type {
            case .plus:
                return plusButton
            case .pomodoro:
                return pomodoroButton
            case .text(let text):
                return button(with: text)
        }
    }
    
    // MARK: - Private Methods
    
    private static func makeButton() -> UIButton {
        let button = QuaterCornerButton()
        button.tintColor = .white
        
        button.imageView?.pin.aspectRatio(1).activate
        
        return button
    }
    
    private static func makeSquareButton(image: UIImage?, color: UIColor) -> UIButton {
        let button = makeButton()
        
        button.pin.aspectRatio(1).activate
        button.imageView?.heightAnchor
            .constraint(equalTo: button.heightAnchor,
                        multiplier: 0.6).isActive = true
        
        button.setImage(image, for: .normal)
        button.backgroundColor = color
        
        return button
    }
    
    private static var plusButton: UIButton {
        makeSquareButton(image: Constants.plusImage.template, color: .red)
    }
    
    private static var pomodoroButton: UIButton {
        makeSquareButton(image: Constants.pomodoroImage.template, color: .green)
    }
    
    private static func button(with text: String) -> UIButton {
        let button = makeButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(.gray, for: . highlighted)
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
