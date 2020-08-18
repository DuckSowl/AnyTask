//
//  AddTaskViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 15.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit
import Pin

class AddTaskViewController: BottomExpandingViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let plusButtonImage = UIImage(named: "plus")!
        static let plusButtonImageInset: CGFloat = 8
        static let plusButtonSize: CGFloat = 40
        
        static let cellId = "itemCell"
        
        static let cornerRadius: CGFloat = 8
        
        static let topOffset: CGFloat = 50
        static let contentInset: CGFloat = 12
        static let spacer: CGFloat = 8
        static let collectionViewHeight: CGFloat = 44
    }
    
    // MARK: - Properties
    
    typealias ViewModel = AddTaskViewModel
    
    private let viewModel: AddTaskViewModel
    
    private var titleBottomConstraint: NSLayoutConstraint? = nil
    
    // MARK: - Subviews
    
    private let titleTextView: UITextView = {
        let titleTextView = makeTextView()
        titleTextView.isScrollEnabled = false
        
        // TODO: Rework to Font manager
        titleTextView.font = UIFont
            .preferredFont(forTextStyle: .title3)
            .roundedIfAvailable()
        
        titleTextView.becomeFirstResponder()
        return titleTextView
    }()
    
    private let addTaskButton: UIButton = {
        let addTaskButton = UIButton()
        addTaskButton.backgroundColor = .red
        addTaskButton.set(cornerRadius: Constants.cornerRadius)
        addTaskButton.clipsToBounds = true
        
        addTaskButton.setImage(Constants.plusButtonImage.withRenderingMode(.alwaysTemplate),
                        for: .normal)
        addTaskButton.imageEdgeInsets = .init(same: Constants.plusButtonImageInset)
        addTaskButton.tintColor = .white
        
        return addTaskButton
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 80, height: 50)
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        
        collectionView.register(ItemCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.cellId)
        
        // TODO: Rework to Color manager
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private var commentTextView: UITextView?
    
    // MARK: - Initializers
    
    init(_ viewModel: AddTaskViewModel) {
        self.viewModel = viewModel
                
        super.init()
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = UIView()
        
        configureSubviews()
        configureConstraints()
        
        setupKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        updateContentHeight()
    }
        
    // MARK: - View Configuration
    
    private func configureSubviews() {
        titleTextView.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addTaskButton.addTarget(self, action: #selector(addTask),
                                for: .touchUpInside)
    }
    
    private func configureConstraints() {
        titleTextView.pin(super: contentView)
            .top(Constants.contentInset)
            .sides(Constants.contentInset)
            .activate
        
        titleBottomConstraint =
            titleTextView.pin.above(collectionView, Constants.spacer).constraints.first
        
        collectionView.pin(super: contentView)
            .add(titleBottomConstraint!)
            .left(Constants.contentInset)
            .height(Constants.collectionViewHeight)
            .bottom(Constants.contentInset)
            .activate
        
        addTaskButton.pin(super: contentView)
            .vCenter(of: collectionView)
            .after(collectionView, Constants.spacer)
            .size(Constants.plusButtonSize)
            .right(Constants.contentInset)
            .activate
    }
    
    private var backgroundContentHeight: CGFloat {
        [titleTextView, commentTextView]
            .compactMap { $0 }
            .map { $0.sizeThatFits($0.frame.size).height }
            .withAppend(Constants.contentInset * 2,
                        Constants.spacer,
                        Constants.collectionViewHeight)
            .withAppend(commentTextView != nil ? [Constants.spacer] : [])
            .print()
            .reduce(0, +)
    }
    
    // MARK: - Private Methods
    
    private static func makeTextView() -> UITextView {
        let textView = UITextView()
        
        // TODO: Rework to Color manager
        textView.backgroundColor = .white
        textView.set(cornerRadius: Constants.cornerRadius)
        
        textView.adjustsFontForContentSizeCategory = true

        return textView
    }
    
    private func updateContentHeight() {
        let maxContentHeight = view.frame.maxY - Constants.topOffset
        contentHeight = min(backgroundContentHeight, maxContentHeight)
    }
    
    private func addCommentView() {
        commentTextView = Self.makeTextView()
        
        // TODO: Rework to Font manager
        commentTextView?.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .roundedIfAvailable()
        
        commentTextView?.delegate = self
        
        configureCommentViewConstraints()
        updateContentHeight()
    }
    
    private func configureCommentViewConstraints() {
        titleBottomConstraint?.isActive = false
        titleBottomConstraint =
            commentTextView?.pin.below(titleTextView, Constants.spacer).constraints.first
        
        commentTextView?.pin(super: contentView)
            // TODO: Fix force unwrap in LittlePin
            .add(titleBottomConstraint!)
            .above(collectionView, Constants.spacer)
            .sides(Constants.contentInset)
            .activate
    }
    
    // MARK: - Actions
    
    @objc private func addTask() {
        notImplementedAlert()
    }
}

extension AddTaskViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView == titleTextView
            ? !text.contains("\n") && (textView.text as NSString)
                .replacingCharacters(in: range, with: text)
                .count < ViewModel.maxTitleLength
            : true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateContentHeight()
    }
}

// MARK: - UICollectionViewDelegate

extension AddTaskViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.items[indexPath.row].chosen.toggle()
        
        if viewModel.items[indexPath.row].type == .comment {
            addCommentView()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension AddTaskViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId,
                                                      for: indexPath) as! ItemCollectionViewCell
        
        cell.viewModel = viewModel.items[indexPath.row]
        
        return cell
    }
}

// MARK: - AddTaskViewModelDelegate

extension AddTaskViewController: AddTaskViewModelDelegate {
    func itemsDidChange() {
        collectionView.reloadData()
    }
}

// MARK: - UITraitCollection

extension AddTaskViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateContentHeight()
    }
}

