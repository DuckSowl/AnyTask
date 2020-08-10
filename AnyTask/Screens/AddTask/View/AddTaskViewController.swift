//
//  AddTaskViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 15.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    typealias ViewModel = AddTaskViewModel
        
    // MARK: - Private Properties
    
    private var heightConstraint: NSLayoutConstraint!
    
    private var backgroundContentHeight: CGFloat {
        [titleTextView, commentTextView, addButton]
            .map { $0.sizeThatFits($0.frame.size).height }
            .withAppend(contentsOf: [ViewModel.topAnchor,
                                     ViewModel.bottomAnchor * 2,
                                     ViewModel.textSeparatorAnchor])
            .reduce(0, +)
    }
    
    private lazy var titleTextView: UITextView = {
        let titleTextView = makeTextView()
        titleTextView.font = ViewModel.titleFont
        titleTextView.becomeFirstResponder()
        return titleTextView
    }()
    
    private lazy var commentTextView: UITextView = {
        let commentTextView = makeTextView()
        commentTextView.font = ViewModel.smallFont
        return commentTextView
    }()
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle(ViewModel.addButtonText, for: .normal)
        addButton.titleLabel?.font = ViewModel.smallFont
        addButton.setTitleColor(ViewModel.textColor, for: .normal)
        
        addButton.layer.cornerRadius = ViewModel.addButtonCornerRadius
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = ViewModel.secondColor.cgColor
        addButton.contentEdgeInsets = ViewModel.addButtonContentEdgeInsets
        
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        return addButton
    }()
    
    private lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        view.addSubview(backgroundView)
        
        backgroundView.backgroundColor = ViewModel.backgroundColor
        
        backgroundView.setCorner(radius: ViewModel.cornerRadius,
                                 for: [.topLeft, .topRight])
        backgroundView.clipsToBounds = true
        
        heightConstraint = backgroundView.pin
            .height(backgroundContentHeight)
            .constraints.first
        
        backgroundView.pin
            .left().right().bottom()
            .add(heightConstraint)
            .activate
                
        return backgroundView
    }()
    
    // MARK: - View LifeCycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = ViewModel.shadeColor
        backgroundView.addSubview(addButton)
        
        let textScrollView = setupTextScrollView()
        setupViewConstraints(with: textScrollView)
        
        setupKeyboardNotifications()
    }
    
    // MARK: - Setup View
    
    private func setupTextScrollView() -> UIScrollView {
        let textScrollView = UIScrollView()
        let subviews = [titleTextView, commentTextView]
        subviews.forEach { textScrollView.addSubview($0) }
        
        backgroundView.addSubview(textScrollView)
        return textScrollView
    }
    
   
    
    private func setupViewConstraints(with textScrollView: UIScrollView) {
        titleTextView.pin
            .top().sides()
            .sides(to: backgroundView, ViewModel.sideAnchor)
            .activate

        commentTextView.pin
            .left().right().bottom()
            .below(titleTextView, ViewModel.textSeparatorAnchor)
            .activate
        
        textScrollView.pin
            .sides(ViewModel.sideAnchor)
            .top(ViewModel.topAnchor)
            .above(addButton, ViewModel.bottomAnchor)
            .activate
        
        addButton.pin
            .right(ViewModel.sideAnchor)
            .bottom(ViewModel.bottomAnchor)
            .activate
    }

    // MARK: - Private Methods
    
    private func makeTextView() -> UITextView {
        let textView = UITextView()
        
        textView.adjustsFontForContentSizeCategory = true
        textView.isScrollEnabled = false
        
        textView.delegate = self
        
        return textView
    }
        
    private func updateViewHeight() {
        heightConstraint.constant = min(backgroundContentHeight,
        // View height from top to keyboard
            view.frame.maxY - ViewModel.topOffset)
    }
    
    private func moveToParent() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    // MARK: - Actions
    
    @objc private func addTask() {
        if let title = titleTextView.text,
            title.count > 0 {
            
            print("Implement task adding to model")
            moveToParent()
        }
    }
    
    // MARK: - Keyboard Notifications
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillShow),
                         name: UIResponder.keyboardWillShowNotification,
                         object: nil)
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillHide),
                         name: UIResponder.keyboardWillHideNotification,
                         object: nil)
    }
        
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: - UITraitCollection
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateViewHeight()
    }
}

extension AddTaskViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return (textView == titleTextView) ? !text.contains("\n") : true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateViewHeight()
    }

    // TODO: - Add placeholder
}

