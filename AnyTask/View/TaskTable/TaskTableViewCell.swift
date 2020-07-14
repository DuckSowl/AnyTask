//
//  TaskTableViewCell.swift
//  AnyTask
//
//  Created by Anton Tolstov on 13.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK: - ViewModel
    
    typealias ViewModel = TaskViewModel
    
    var viewModel: TaskViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
                
            titleLabel.text = viewModel.title
            commentLabel.text = viewModel.comment
            expectedTimeLabel.text = viewModel.estimatedTime
            projectLabel.text = viewModel.project
            deadlineLabel.text = viewModel.deadline
        }
    }
    
    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = makeLabel(font: ViewModel.titleFont)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private lazy var projectLabel: UILabel = {
        makeLabel(font: ViewModel.smallFont)
    }()
    
    private lazy var deadlineLabel: UILabel = {
        makeLabel(font: ViewModel.smallFont)
    }()
    
    private lazy var commentLabel: UILabel = {
        let commentLabel = makeLabel(font: ViewModel.smallFont)
        commentLabel.numberOfLines = 0
        return commentLabel
    }()
    
    private lazy var expectedTimeLabel: UILabel = {
        makeLabel(font: ViewModel.smallFont)
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        selectionStyle = .none
        
        setupBackgroundView()
        setupViewConstraints()
    }
    
    private func setupBackgroundView() {
        backgroundColor = .clear
        backgroundView = UIView()
        
        guard let backgroundView = backgroundView else { return }
        
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateFrom(insets: ViewModel.backgroundInsets,
                                        subview: backgroundView,
                                        superview: self)
        backgroundView.layer.cornerRadius = ViewModel.cornerRadius
    }
    
    private func setupViewConstraints() {
        guard let backgroundView = backgroundView else { return }

        NSLayoutConstraint.activate([
            // Title
            titleLabel.leadingAnchor
                .constraint(equalTo: backgroundView.leadingAnchor,
                            constant: ViewModel.sideAnchor),
            titleLabel.topAnchor
                .constraint(equalTo: backgroundView.topAnchor,
                            constant: ViewModel.topAnchor),
            
            // ExpectedTime
            expectedTimeLabel.trailingAnchor
                .constraint(equalTo: backgroundView.trailingAnchor,
                            constant: -ViewModel.sideAnchor),
            expectedTimeLabel.topAnchor
                .constraint(equalTo: backgroundView.topAnchor,
                            constant: ViewModel.topAnchor),
            
            // Title - ExpectedTime
            titleLabel.trailingAnchor
                .constraint(lessThanOrEqualTo: expectedTimeLabel.leadingAnchor,
                            constant: -ViewModel.sideAnchor),
            
            // Comment
            commentLabel.leadingAnchor
                .constraint(equalTo: backgroundView.leadingAnchor,
                            constant: ViewModel.sideAnchor),
            commentLabel.trailingAnchor
                .constraint(equalTo: backgroundView.trailingAnchor,
                            constant: -ViewModel.sideAnchor),
            commentLabel.topAnchor
                .constraint(equalTo: titleLabel.bottomAnchor,
                            constant: ViewModel.topAnchor),
            commentLabel.bottomAnchor
                .constraint(equalTo: deadlineLabel.topAnchor,
                            constant: -ViewModel.bottomAnchor),
            
            // Deadline
            deadlineLabel.leadingAnchor
                .constraint(equalTo: backgroundView.leadingAnchor,
                            constant: ViewModel.sideAnchor),
            deadlineLabel.bottomAnchor
                .constraint(equalTo: backgroundView.bottomAnchor,
                            constant: -ViewModel.bottomAnchor),
            
            // Deadline - Project
            deadlineLabel.trailingAnchor
                .constraint(lessThanOrEqualTo: projectLabel.leadingAnchor,
                            constant: -ViewModel.sideAnchor),
            
            // Project
            projectLabel.trailingAnchor
                .constraint(equalTo: backgroundView.trailingAnchor,
                            constant: -ViewModel.sideAnchor),
            projectLabel.bottomAnchor
                .constraint(equalTo: backgroundView.bottomAnchor,
                            constant: -ViewModel.topAnchor),
        ])
        
        // Prevent expectedTimeLabel from shrinking
        expectedTimeLabel
            .setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    // MARK: - Private Methods

    private func makeLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true

        backgroundView?.addSubview(label)
        return label
    }
}
