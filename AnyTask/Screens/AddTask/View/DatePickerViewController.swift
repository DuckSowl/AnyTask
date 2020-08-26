//
//  DeadlinePickerViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 20.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol DatePickerDelegate: AnyObject {
    func didSelect(deadline: Date)
}

class DatePickerViewController: BottomExpandingViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let contentInset: CGFloat = 12
        static let spacer: CGFloat = 8
    }
    
    // MARK: - Properties
    
    weak var delegate: DatePickerDelegate?
    
    // Constraint to deal with bottom SafeArea
    var bottomConstraint: NSLayoutConstraint!
        
    // MARK: - Subviews
    
    let datePickerView = UIDatePicker()
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        // TODO: Rework to Color manager
        if #available(iOS 13.0, *) {
            contentView.backgroundColor = .systemGray6
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = UIView()
        
        configureSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentHeight = 300
    }
    
    override func viewWillLayoutSubviews() {
        if #available(iOS 11.0, *) {
            bottomConstraint?.constant = -view.safeAreaInsets.bottom
        }
    }
        
    // MARK: - View Configuration
    
    private func configureSubviews() {
        datePickerView.minimumDate = Date()
                
        let button = Button.with(type: .text("Add Time"))
        // TODO: Rework to Color manager
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(selectDate),
                         for: .touchUpInside)
        
        configureConstraints(addTimeButton: button)
    }
    
    private func configureConstraints(addTimeButton: UIButton) {
        datePickerView.pin(super: contentView)
            .sides().top()
            .activate
                
        addTimeButton.pin(super: contentView)
            .sides(Constants.contentInset)
            .below(datePickerView, Constants.spacer)
            .activate
        
        let bottomPin = addTimeButton.pin.bottom()
        bottomConstraint = bottomPin.constraints.first!
        bottomPin.activate
    }
    
    // MARK: - Actions
    
    @objc private func selectDate() {
        delegate?.didSelect(deadline: datePickerView.date)
        remove()
    }
}
