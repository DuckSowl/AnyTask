//
//  ProjectTopBarView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 10.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol ProjectTopBarDelegate: BackDelegate { }

final class ProjectTopBarView: TopBarView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let moreButtonImage = UIImage(named: "more")
        static let backButtonImage = UIImage(named: "back")
    }
    
    // MARK: - Properties
    
    private let viewModel: ProjectViewModel
    
    weak var delegate: ProjectTopBarDelegate?
    
    // MARK: - Subviews
    
    let moreButton = button(with: Constants.moreButtonImage)
    
    let backButton: UIButton = {
        let newButton = button(with: Constants.backButtonImage)
        newButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        return newButton
    }()
    
    let projectLabel: UILabel = {
        let projectLabel = UILabel()
        projectLabel.font = Font.title
        return projectLabel
    }()

    init(_ viewModel: ProjectViewModel) {
        self.viewModel = viewModel
                
        super.init()
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func configureSubviews() {
        projectLabel.text = viewModel.name
        
        rightButtonsStack.addArrangedSubview(moreButton)
        moreButton.addTarget(self, action: #selector(more), for: .touchUpInside)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        moreButton.pin.aspectRatio(1).activate
        
        backButton.pin(super: contentView)
            .left(10).topBottom(12).aspectRatio(1)
            .activate
        
        projectLabel.pin(super: contentView)
            .after(backButton).vCenter().before(searchButton)
            .activate
    }
    
    // MARK: - Actions
    
    @objc private func back() {
        delegate?.back()
    }
    
    @objc private func more() { notImplementedAlert() }
}
