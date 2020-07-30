//
//  TabBarView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 02.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TabBarView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: TabBarDelegate?
    
    private typealias ViewModel = TabBarViewModel
    private var selectedTabButton: TabBarButtonView?
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: CGRect.zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        setupBackgroundView()
        let buttons = self.buttons
        setupStackView(with: buttons)
    }
    
    private func setupBackgroundView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = ViewModel.backgroundColor
        
        // TODO: fix for iPhones without rounded corners
        backgroundView.layer.cornerRadius = ViewModel.cornerRadius
        
        self.addSubview(backgroundView)
        backgroundView.pin
            .top(ViewModel.addButtonOffset)
            .bottom(-ViewModel.addButtonOffset)
            .sides().activate
    }
    
    private var buttons: [TabBarButtonView] {
        // Tab buttons
        var buttons: [TabBarButtonView] = Tab.allCases.map { tab in
            let tabButtonViewModel = TabButtonViewModel(tab: tab)
            let tabButtonView = TabBarButtonView(tabButtonViewModel)
            tabButtonView.addTarget(self, action: #selector(didSelectTab),
                                    for: .touchDown)
            return tabButtonView
        }
        
        // `Add` button
        let addButtonViewModel = AddButtonViewModel()
        let addButtonView = TabBarButtonView(addButtonViewModel)
        addButtonView.addTarget(self, action: #selector(didPressAdd),
                                for: .touchUpInside)
        buttons.insert(addButtonView, at: 2) // In the middle
        
        // Pre-select first tab
        self.didSelectTab(sender: buttons.first!)
        
        return buttons
    }
    
    private func setupStackView(with buttons: [TabBarButtonView]) {
        let stack = UIStackView(arrangedSubviews: buttons)
        self.addSubview(stack)
        stack.distribution = .equalSpacing
        stack.alignment = .bottom
        
        self.pin.height(ViewModel.heightAnchor).activate
        stack.pin.sides(ViewModel.sideAnchor)
            .top().activate
    }
    
    // MARK: - Button Actions
    
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
