//
//  TabBarView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 02.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TabBarView: UIView {
    
    private typealias ViewModel = TabBarViewModel
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = ViewModel.backgroundColor
        // TODO: fix for iPhones without rounded corners
        self.layer.cornerRadius = ViewModel.cornerRadius
        
        var buttons: [TabBarButtonView] = Tab.allCases.map { tab in
            let tabButtonViewModel = TabButtonViewModel(tab: tab)
            return TabBarButtonView(tabButtonViewModel)
        }
        
        let addButtonViewModel = AddButtonViewModel()
        let addButtonView = TabBarButtonView(addButtonViewModel)
        buttons.insert(addButtonView, at: 2) // In the middle
        
        let stack = UIStackView(arrangedSubviews: buttons)
        self.addSubview(stack)
        stack.distribution = .equalSpacing
        stack.alignment = .bottom
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Offset top so that plus button slightly over the edge
            // TODO: fix inability to tap on that excessing top part
            stack.topAnchor.constraint(equalTo: topAnchor,
                                       constant: ViewModel.topAnchorConstant),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: ViewModel.sideAnchorConstant),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor,
                                            constant: -ViewModel.sideAnchorConstant),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
