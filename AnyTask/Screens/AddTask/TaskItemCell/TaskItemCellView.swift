//
//  TaskItemCellView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 11.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TaskItemCellView: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let borderWidth: CGFloat = 1.6
        
        static let inset: CGFloat = 6
        static let imageHeight: CGFloat = 24
    }
    
    // MARK: - Properties
    
    var viewModel: TaskItemViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            imageView.image = viewModel.image?.template
            imageView.tintColor = Color.dark
            textView.text = viewModel.comment
            
            contentView.backgroundColor = viewModel.chosen ? Color.darkGray
                                                           : Color.clear
            
            configureConstraints(chosen: viewModel.chosen)
        }
    }
    
    // MARK: - Subviews
    
    let imageView = UIImageView()
        .with(contentMode: .scaleAspectFit)
        .as(UIImageView.self)
    
    let textView = UILabel()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        textView.textAlignment = .center
        contentView.set(cornerRadius: .small)
    }
        
    private func configureConstraints(chosen: Bool) {
        [imageView, textView].forEach { $0.unpin.activate }
        
        if chosen {
            imageView.pin(super: contentView)
                .topBottom(Constants.inset)
                .left(Constants.inset)
                .height(Constants.imageHeight)
                .aspectRatio(1)
                .activate
            
            textView.pin(super: contentView)
                .topBottom(Constants.inset)
                .right(Constants.inset)
                .after(imageView, Layout.spacer)
                .activate
            
        } else {
            imageView.pin(super: contentView)
                .all(Constants.inset)
                .height(Constants.imageHeight)
                .aspectRatio(1)
                .activate
        }
    }
}
