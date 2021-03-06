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
        static let plusButtonSize: CGFloat = 40
        
        static let cellId = "itemCell"
                
        static let topOffset: CGFloat = 50
        static let collectionViewHeight: CGFloat = 50
    }
    
    // MARK: - Properties
    
    typealias ViewModel = AddTaskViewModel
    
    private var viewModel: AddTaskViewModel {
        didSet {
            collectionView.reloadData()
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    private var titleBottomConstraint: NSLayoutConstraint? = nil
    
    // MARK: - Subviews
    
    let titleTextView: UITextView = {
        let titleTextView = makeTextView()
        titleTextView.isScrollEnabled = false
        
        titleTextView.font = Font.subtitle
        
        titleTextView.becomeFirstResponder()
        return titleTextView
    }()
    
    private let addTaskButton = Button.with(type: .plus)
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 80, height: 50)
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        
        collectionView.register(TaskItemCellView.self,
                                forCellWithReuseIdentifier: Constants.cellId)
        
        collectionView.backgroundColor = Color.clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    var commentTextView: UITextView?
    
    // MARK: - Initializers
    
    init(_ viewModel: AddTaskViewModel) {
        self.viewModel = viewModel
                
        super.init()
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
        maxHeight = view.frame.maxY - Constants.topOffset
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
            .top(Layout.contentInset)
            .sides(Layout.contentInset)
            .activate
        
        titleBottomConstraint =
            titleTextView.pin.above(collectionView, Layout.spacer).constraints.first
        
        collectionView.pin(super: contentView)
            .add(titleBottomConstraint!)
            .left(Layout.contentInset)
            .height(Constants.collectionViewHeight)
            .bottom(Layout.contentInset)
            .activate
        
        addTaskButton.pin(super: contentView)
            .vCenter(of: collectionView)
            .after(collectionView, Layout.spacer)
            .height(40)
            .right(Layout.contentInset)
            .activate
    }
    
    // MARK: - Private Methods
    
    private static func makeTextView() -> UITextView {
        let textView = UITextView()
        
        textView.backgroundColor = Color.light
        textView.set(cornerRadius: .small)
        
        textView.adjustsFontForContentSizeCategory = true

        return textView
    }
    
    private func updateContentHeight() {
        contentHeight = [titleTextView, commentTextView]
            .compactMap { $0 }
            .map { $0.sizeThatFits($0.frame.size).height }
            .withAppend(Layout.contentInset * 2,
                        Layout.spacer,
                        Constants.collectionViewHeight)
            .withAppend(commentTextView != nil ? [Layout.spacer] : [])
            .reduce(0, +)
    }
    
    func addCommentView() {
        commentTextView = Self.makeTextView()
        
        commentTextView?.font = Font.body
        
        commentTextView?.delegate = self
        
        configureCommentViewConstraints()
        updateContentHeight()
    }
    
    private func configureCommentViewConstraints() {
        titleBottomConstraint?.isActive = false
        titleBottomConstraint =
            commentTextView?.pin.below(titleTextView, Layout.spacer).constraints.first
        
        commentTextView?.pin(super: contentView)
            .add(titleBottomConstraint)
            .above(collectionView, Layout.spacer)
            .sides(Layout.contentInset)
            .activate
    }
    
    // MARK: - Private Methods
    
    private func didSelect(item: TaskItem.ItemType) {
        switch item {
            case .comment:
                viewModel.addComment()
                addCommentView()
            case .project:
                let projectPickerViewController =
                    ProjectPickerViewController(viewModel.projectsViewModel, style: .pick)
                projectPickerViewController.delegate = self
                add(projectPickerViewController, frame: view.bounds)
            case .deadline:
                let deadlinePickerViewController = DatePickerViewController()
                deadlinePickerViewController.delegate = self
                resignFirstResponders()
                add(deadlinePickerViewController, frame: UIScreen.main.bounds)
            default: break
        }
    }
    
    private func resignFirstResponders() {
        [titleTextView, commentTextView].forEach { $0?.resignFirstResponder() }
    }
    
    // MARK: - Actions
    
    @objc private func addTask() {
        if let title = titleTextView.text {
            if viewModel.addTask(title: title,
                                 comment: commentTextView?.text) {
                remove()
            } else {
                showAlert(title: "Wrong title length", message: viewModel.wrongLengthAlertMessage)
            }
        }
    }
}

extension AddTaskViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView == titleTextView
            ? !text.contains("\n") && (textView.text as NSString)
                .replacingCharacters(in: range, with: text)
                .count < viewModel.titleLength.max()!
            : true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateContentHeight()
    }
}

// MARK: - UICollectionViewDelegate

extension AddTaskViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect(item: viewModel.items[indexPath.row].type)
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
                                                      for: indexPath) as! TaskItemCellView
        
        cell.viewModel = viewModel.items[indexPath.row]
        
        return cell
    }
}

// MARK: - UITraitCollection

extension AddTaskViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateContentHeight()
    }
}

extension AddTaskViewController: ProjectPickerDelegate {
    func didSelect(projectVM: ProjectViewModel) {
        titleTextView.becomeFirstResponder()
        viewModel.add(projectVM: projectVM)
    }
}

extension AddTaskViewController: DatePickerDelegate {
    func didSelect(deadline: Date) {
        titleTextView.becomeFirstResponder()
        viewModel.add(deadline: deadline)
    }
}
