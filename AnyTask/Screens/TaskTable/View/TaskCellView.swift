//
//  TaskCellView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 13.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TaskCellView: UITableViewCell {
    
    // MARK: - ViewModel
    
    typealias ViewModel = TaskCellViewModel
    
    var viewModel: TaskCellViewModel? {
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
        backgroundColor = Color.clear
        backgroundView = UIView()
        
        guard let backgroundView = backgroundView else { return }
        
        backgroundView.backgroundColor = Color.light
        backgroundView.pin
            .sides(ViewModel.backgroundSides)
            .topBottom(ViewModel.backgroundTopButton)
            .activate
        
        backgroundView.layer.cornerRadius = ViewModel.cornerRadius
    }
    
    private func setupViewConstraints() {
        guard let backgroundView = backgroundView else { return }
           
        titleLabel.pin
            .top(ViewModel.topAnchor)
            .left(ViewModel.sideAnchor)
            .before(expectedTimeLabel, be: .less, ViewModel.sideAnchor)
            .activate
        
        expectedTimeLabel.pin
            .top(ViewModel.topAnchor)
            .right(ViewModel.sideAnchor)
            .activate
        
        commentLabel.pin
            .sides(to: backgroundView, ViewModel.sideAnchor)
            .below(titleLabel, ViewModel.topAnchor)
            .above(deadlineLabel, ViewModel.bottomAnchor)
            .activate
        
        deadlineLabel.pin
            .left(ViewModel.sideAnchor)
            .bottom(ViewModel.bottomAnchor)
            .before(projectLabel, be: .less, ViewModel.sideAnchor)
            .activate
        
        projectLabel.pin
            .right(ViewModel.sideAnchor)
            .bottom(ViewModel.bottomAnchor)
            .activate
                
        // Prevent expectedTimeLabel from shrinking
        expectedTimeLabel
            .setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    // MARK: - Private Methods

    private func makeLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        
        label.adjustsFontForContentSizeCategory = true

        backgroundView?.addSubview(label)
        return label
    }
}
