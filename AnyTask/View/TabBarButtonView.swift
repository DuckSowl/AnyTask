//
//  TabBarButtonView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 02.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TabBarButtonView: UIButton {
    let viewModel: TabBarButtonViewModel
    
    init(_ viewModel: TabBarButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    func setupView() {
        self.setImage(viewModel.icon?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.tintColor = viewModel.iconColor
        
        // TODO: - fix plus button background color peeking over the edge
        self.layer.cornerRadius = viewModel.cornerRadius
        self.backgroundColor = viewModel.backgroundColor
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: viewModel.iconSize.height),
            widthAnchor.constraint(equalToConstant: viewModel.iconSize.width)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
