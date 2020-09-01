//
//  TaskCellView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 13.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TaskCellView: SwipeableTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let checkmarkImage = UIImage(named: "checkmark")!
        static let trashImage = UIImage(named: "trash")!
        static let swipeViewImageHeight: CGFloat = 32
        static let imageSideOffset: CGFloat = 20
        
        static let cornerRadius: CGFloat = 14
        
        static let spacer: CGFloat = 8
        static let cellInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        static let contentInset: CGFloat = 12
    }
    
    // MARK: - Properties
    
    var viewModel: TaskViewModel? {
        didSet { configureFromViewModel() }
    }
    
    // MARK: - Subviews
    
    private let titleLabel: UILabel = {
        let titleLabel = makeLabel(font: Font.subtitle)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private let projectLabel = makeLabel(font: Font.body)
    
    private let deadlineLabel = makeLabel(font: Font.body)
    
    private let commentLabel: UILabel = {
        let commentLabel = makeLabel(font: Font.body)
        commentLabel.numberOfLines = 0
        return commentLabel
    }()
    
    private let expectedTimeLabel = makeLabel(font: Font.body)
    
    private let deletionView = UIView()
        .with(backgroundColor: Color.red)
        .with(cornerRadius: Constants.cornerRadius)
    
    private let completionView = UIView()
        .with(backgroundColor: Color.green)
        .with(cornerRadius: Constants.cornerRadius)
    
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
        
        configureBackgroundView()
        configureContentConstraints()
        configureCompletionDeletionViews()
    }
    
    private func configureBackgroundView() {
        backgroundColor = Color.clear
        swipableContentView.backgroundColor = Color.gray
        swipableContentView.set(cornerRadius: Constants.cornerRadius)
    }
    
    private func configureContentConstraints() {
        titleLabel.pin(super: swipableContentView)
            .top(Constants.contentInset)
            .left(Constants.contentInset)
            .activate
        
        expectedTimeLabel.pin(super: swipableContentView)
            .top(Constants.spacer)
            .right(Constants.contentInset)
            .after(titleLabel, be: .less, -Constants.spacer)
            .activate
        
        commentLabel.pin(super: swipableContentView)
            .sides(Constants.contentInset)
            .height(be: .less, 100)
            .below(titleLabel, Constants.spacer)
            .activate
        
        deadlineLabel.pin(super: swipableContentView)
            .left(Constants.contentInset)
            .below(commentLabel, Constants.spacer)
            .bottom(Constants.contentInset)
            .activate
        
        projectLabel.pin(super: swipableContentView)
            .right(Constants.contentInset)
            .bottom(Constants.contentInset)
            .after(deadlineLabel, be: .greater, -Constants.spacer)
            .activate
                
        // Prevent expectedTimeLabel from shrinking
        expectedTimeLabel
            .setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func configureCompletionDeletionViews() {
        completionView.pin(super: swipableContentView).all().activate
        makeImageView(with: Constants.checkmarkImage)
            .pin(super: completionView)
            .height(Constants.swipeViewImageHeight)
            .left(Constants.imageSideOffset)
            .vCenter()
            .activate
        
        deletionView.pin(super: swipableContentView).all().activate
        makeImageView(with: Constants.trashImage)
            .pin(super: deletionView)
            .height(Constants.swipeViewImageHeight)
            .right(Constants.imageSideOffset)
            .vCenter()
            .activate
    }
    
    // MARK: - Private Methods
    
    private func configureFromViewModel() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        commentLabel.text = viewModel.comment
        expectedTimeLabel.text = viewModel.estimatedTime
        
        projectLabel.text = viewModel.project
        projectLabel.isHidden = viewModel.style == .noProject
        
        deadlineLabel.text = viewModel.deadline
        deadlineLabel.isHidden = viewModel.style == .noDeadline
    }

    private static func makeLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        
        label.adjustsFontForContentSizeCategory = true
        return label
    }
    
    private func makeImageView(with image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image.template)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = Color.light
        return imageView
    }
    
    override func swipeChanged(offset: CGFloat) {
        if offset <= -1 {
            viewModel?.complete()
        }
        
        if offset >= 1 {
            viewModel?.delete()
        }
        
        deletionView.alpha = offset * 7
        completionView.alpha = -offset * 7
    }
}
