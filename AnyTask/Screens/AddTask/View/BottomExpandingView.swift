//
//  BottomExpandingView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 12.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class BottomExpandingViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 10
    }

    // MARK: - Properties

    private var topConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    
    var contentHeight: CGFloat? {
        didSet {
            if let contentHeight = contentHeight {
                heightConstraint.constant = contentHeight
            }
            
            let intrinsicContentSize = contentHeight == nil
            topConstraint.isActive = intrinsicContentSize
            heightConstraint.isActive = !intrinsicContentSize
        }
    }

    // MARK: - Subviews

    let contentView: UIView = {
        let contentView = UIView()
        
        // TODO: Rework to Color manager
        if #available(iOS 13.0, *) {
            contentView.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        contentView.clipsToBounds = true
        contentView.set(cornerRadius: Constants.cornerRadius, for: .top)

        return contentView
    }()

    // MARK: - Initializers

    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureView()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        // TODO: Rework to Color manager
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        let tap = OnlySelfTapGestureRecognizer(target: self,
                                               action: #selector(remove))
        self.view.addGestureRecognizer(tap)
    }

    private func configureConstraints() {
        topConstraint = contentView.pin(super: view)
            .top().constraints.first
        
        heightConstraint = contentView.pin
            .height(0).constraints.first
        
        contentView.pin
            .sides().bottom()
            .add(topConstraint)
            .activate
    }
}
