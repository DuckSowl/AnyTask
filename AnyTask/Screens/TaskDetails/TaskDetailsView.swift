//
//  TaskDetailsView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 02.09.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TaskDetailsView: DismissibleView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let commentMaxHeight = UIScreen.main.bounds.height / 2
        
        static let backButtonImage = UIImage(named: "xmark")!
    }
    
    // MARK: - Properties
    
    var viewModel: TaskViewModel {
        didSet {
            updateFromViewModel()
        }
    }
    
    private func updateFromViewModel() {
        titleLabel.text = viewModel.title
        commentTextView.text = viewModel.comment
        projectLabel.text = viewModel.project
        deadlineLabel.text = viewModel.deadline
    }
    
    // MARK: - Subviews
    
    private let titleLabel = UILabel(font: Font.title)
    private let commentTextView = UITextView()
    
    private let deadlineLabel = UILabel(font: Font.subtitle)
    private let projectLabel = UILabel(font: Font.subtitle)
     
    // MARK: - Initializers
    
    init(_ viewModel: TaskViewModel) {
        self.viewModel = viewModel
        
        super.init()
        
        updateFromViewModel()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        configureCommentTextViewScrollability()
    }
        
    // MARK: - View Configuration
    
    private func configureView() {
        configureSubviews()
        configureConstraints()
        configureBackButton()
        configureEditDeleteButtons()
        configureCommentTextViewScrollability()
    }
    
    private func configureSubviews() {
        commentTextView.isEditable = false
        commentTextView.backgroundColor = Color.clear
        commentTextView.textContainer.lineFragmentPadding = .zero
        
        contentView.backgroundColor = Color.gray
        contentView.set(cornerRadius: .medium)
        
        titleLabel.numberOfLines = 0
    }
    
    func configureContentConstraints() {
        contentView.pin
            .sides(Layout.contentInset / 2).vCenter()
            .activate
    }
    
    private func configureConstraints() {
        self.addSubview(contentView)
        
        titleLabel.pin(super: contentView)
            .top(Layout.contentInset)
            .left(Layout.contentInset)
            .activate
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        commentTextView.pin(super: contentView)
            .below(titleLabel, Layout.spacer)
            .sides(Layout.contentInset)
            .height(be: .less, Constants.commentMaxHeight)
            .activate
        
        configureDeadlineProjectConstraints()
    }
    
    private func configureBackButton() {
        let backButton = Button.with(type: .image(Constants.backButtonImage))
        backButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        backButton.pin(super: contentView)
            .after(titleLabel, be: .greater, Layout.spacer)
            .right(Layout.contentInset)
            .top(Layout.contentInset)
            .activate
    }
    
    private func configureDeadlineProjectConstraints() {
        let stack = UIStackView(arrangedSubviews: [deadlineLabel, projectLabel])
        print(stack.distribution.rawValue)
        stack.distribution = .equalSpacing
        stack.spacing = Layout.spacer
        stack.pin(super: contentView)
            .below(commentTextView, Layout.spacer)
            .sides(Layout.contentInset)
            .activate
    }
    
    private func configureEditDeleteButtons() {
        let buttons = [makeButton(with: "Edit", action: #selector(editTask), color: nil),
                       makeButton(with: "Delete", action: #selector(deleteTask), color: Color.red)]
        configureBottomButtonsConstraints(buttons: buttons)
    }
    
    private func makeButton(with text: String, action: Selector,
                            color: UIColor?) -> UIButton {
        let button = Button.with(type: .text(text))
        button.addTarget(self, action: action, for: .touchUpInside)
        if let color = color { button.backgroundColor = color }
        return button
    }
    
    private func configureBottomButtonsConstraints(buttons: [UIButton]) {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.distribution = .fillEqually
        stack.spacing = Layout.spacer
        stack.setContentCompressionResistancePriority(.required, for: .vertical)
        stack.pin(super: contentView)
            .below(projectLabel, Layout.spacer)
            .sides(Layout.spacer)
            .bottom(Layout.contentInset)
            .activate
    }
    
    private func configureCommentTextViewScrollability() {
        commentTextView.isScrollEnabled = commentTextView.sizeThatFitsSelf.height > Constants.commentMaxHeight
    }
    
    // MARK: - Actions
    
    @objc private func editTask() {
        showNotImplementedAlert()
    }
    
    @objc private func deleteTask() {
        showNotImplementedAlert()
    }
}
