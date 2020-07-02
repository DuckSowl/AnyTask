//
//  TabBarView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 02.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TabBarView: UIView {
    
    weak var delegate: TabBarDelegate?
    
    private typealias ViewModel = TabBarViewModel
    private var selectedTabButton: TabBarButtonView?
    
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
            let tabButtonView = TabBarButtonView(tabButtonViewModel)
            tabButtonView.addTarget(self, action: #selector(didSelectTab),
                                    for: .touchDown)
            return tabButtonView
        }
        
        // Pre-select first tab
        self.didSelectTab(sender: buttons.first!)
        
        let addButtonViewModel = AddButtonViewModel()
        let addButtonView = TabBarButtonView(addButtonViewModel)
        addButtonView.addTarget(self, action: #selector(didPressAdd),
                                for: .touchUpInside)
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
    
    @objc private func didSelectTab(sender: UIButton) {
        guard sender != selectedTabButton else { return }
        
        if let selectedTabButton = selectedTabButton {
            selectedTabButton.isSelected = false
        }
        sender.isSelected = true
        
        if let tabButton = sender as? TabBarButtonView,
            let tab = tabButton.getTab() {
            self.selectedTabButton = tabButton
            self.delegate?.didSelect(tab: tab)
        }
    }
    
    @objc private func didPressAdd(sender: UIButton) {
        delegate?.didPressAdd()
        print(sender.bounds)
        print(sender.frame)
    }
}

protocol TabBarDelegate: AnyObject {
    func didSelect(tab: Tab)
    func didPressAdd()
}
