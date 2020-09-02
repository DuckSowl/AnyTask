//
//  ProjectPickerViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 18.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol ProjectPickerDelegate: Delegate {
    func didSelect(projectVM: ProjectViewModel)
}

class ProjectPickerViewController: BottomExpandingViewController {
    
    // MARK: - Properties
    
    weak var delegate: ProjectPickerDelegate?
    
    private let viewModel: ProjectsViewModel
    private let tableViewModel: ProjectsTableViewModel?
    
    private let style: Style
    
    // MARK: - Subviews
    
    private let projectsTableView: ProjectsTableView?
    
    private let addTextView: AddTextView
    
    // MARK: - Initializers
    
    init(_ viewModel: ProjectsViewModel, style: Style) {
        self.viewModel = viewModel
        if style == .pick {
            tableViewModel = viewModel.tableViewModel(withStyle: .onlyUserDefined)
            projectsTableView = .init(tableViewModel!)
        } else {
            tableViewModel = nil
            projectsTableView = nil
        }
        
        addTextView = .init(maxTextLength: UInt(viewModel.projectNameLengthRange.max()!))
        
        self.style = style
        
        super.init()
        
        contentView.backgroundColor = Color.gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = UIView()
        
        projectsTableView?.delegate = self
        
        configureSubviews()
        configureConstraints()
        if style == .add { setupKeyboardNotifications() }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addTextView.layoutIfNeeded()
        
        contentHeight = addTextView.textField.frame.height
            + Layout.contentInset * 2
            + (style == .add ? 0
            : (projectsTableView?.intrinsicContentSize.height ?? 0)
            + Layout.spacer)
    }
    
    // MARK: - View Configuration
    
    private func configureSubviews() {
        addTextView.textField.becomeFirstResponder()
        addTextView.textField.placeholder = "Add New Project"
        addTextView.delegate = self
        projectsTableView?.set(cornerRadius: .small)
    }
    
    private func configureConstraints() {
        if let projectsTableView = projectsTableView {
            projectsTableView.pin(super: contentView)
                .top(Layout.contentInset)
                .sides(Layout.contentInset)
                .activate
            
            addTextView.pin(super: contentView)
                .below(projectsTableView, Layout.spacer)
                .activate
        }
        
        addTextView.pin(super: contentView)
            .sides(Layout.contentInset)
            .bottom(Layout.contentInset)
            .activate
    }
    
    enum Style {
        case add
        case pick
    }
}

extension ProjectPickerViewController: AddTextDelegate {
    func add(text: String?) {
        if let projectName = text,
            let projectViewModel = viewModel.addProject(withName: projectName) {
            selectAndDismiss(projectVM: projectViewModel)
        } else {
            showAlert(title: "Wrong Project Name",
                      message: viewModel.wrongNameMessage)
        }
    }
    
    private func selectAndDismiss(projectVM: ProjectViewModel) {
        delegate?.didSelect(projectVM: projectVM)
        remove()
    }
}

// MARK: - UITableViewDelegate

extension ProjectPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let projectVM = tableViewModel?.projects[indexPath.row] {
            selectAndDismiss(projectVM: projectVM)
        }
    }
}
