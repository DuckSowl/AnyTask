//
//  SwipeableCollectionViewCell.swift
//  AnyTask
//
//  Created by Anton Tolstov on 27.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit
import Pin

class SwipeableTableViewCell: UITableViewCell {
    
    // MARK: Subviews
    
    let leftSwipeView = UIView()
    let swipableContentView = UIView()
    let rightSwipeView = UIView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
        
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func prepareForReuse() {
        centrateScrollView()
    }
    
    // MARK: - View configuration
    
    private func configureSubviews() {
        scrollView.delegate = self
        
        let views = [leftSwipeView, swipableContentView, rightSwipeView]
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        scrollView.pin(super: self).sides(8).topBottom(4).activate
        stackView.pin(super: scrollView).all().activate
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                             multiplier: 3)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.centrateScrollView()
        }
    }
    
    private func centrateScrollView() {
        scrollView.setContentOffset(.init(x: scrollView.frame.width, y: 0),
                                    animated: false)
    }
    
    // MARK: - Methods
    
    func swipeChanged(offset: CGFloat) { }
}

// MARK: - UIScrollViewDelegate

extension SwipeableTableViewCell: UIScrollViewDelegate  {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        swipeChanged(offset: (scrollView.contentOffset.x / scrollView.frame.width) - 1.0)
    }
}


