//
//  BottomExpandingViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 12.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class BottomExpandingViewController: UIViewController {

    // MARK: - Properties

    private var topConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    
    var maxHeight: CGFloat? {
        didSet { updateHeight() }
    }
    
    var contentHeight: CGFloat? {
        didSet { updateHeight() }
    }

    // MARK: - Subviews

    let contentView: UIView = {
        let contentView = UIView()
        
        contentView.backgroundColor = Color.gray

        contentView.clipsToBounds = true
        contentView.set(cornerRadius: .medium, for: .top)

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
        view.backgroundColor = Color.shade
        
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
    
    private func updateHeight() {
        if let contentHeight = contentHeight {
            heightConstraint.constant =
                min(contentHeight, maxHeight ?? view.fixedSafeHeight)
        }
        
        let intrinsicContentSize = contentHeight == nil
        topConstraint.isActive = intrinsicContentSize
        heightConstraint.isActive = !intrinsicContentSize
    }
}

fileprivate extension UIView {
    var fixedSafeHeight: CGFloat {
        let fixedCoordinates = convert(frame,
                                       to: UIScreen.main.fixedCoordinateSpace)
        var safeHeight = fixedCoordinates.height + fixedCoordinates.origin.y
        if #available(iOS 11.0, *) {
            safeHeight -= safeAreaInsets.top
        }
        return safeHeight
    }
}
