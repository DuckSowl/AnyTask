//
//  ProjectPickerViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 18.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol ProjectPickerDelegate: AnyObject {
    func didSelect(project: ProjectViewModel)
}

class ProjectPickerViewController: BottomExpandingViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let contentInset: CGFloat = 12
        static let spacer: CGFloat = 8
    }
    
    // MARK: - Properties
    
    weak var delegate: ProjectPickerDelegate?
    
    var viewModel: ProjectsViewModel
    let tableViewModel: ProjectsTableViewModel
    
    // MARK: - Subviews
    
    let projectsTableView: ProjectsTableView
    
    let addTextView: AddTextView
    
    // MARK: - Initializers
    
    init(_ viewModel: ProjectsViewModel) {
        self.viewModel = viewModel
        tableViewModel = viewModel.tableViewModel(withStyle: .onlyUserDefined)
        projectsTableView = .init(tableViewModel)
        addTextView = .init(maxTextLength: UInt(viewModel.projectNameLengthRange.max()!))
        
        super.init()
        
        // Rework to Color manager
        if #available(iOS 13.0, *) {
            contentView.backgroundColor = .systemGray5
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = UIView()
        
        projectsTableView.delegate = self
        
        configureSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        contentHeight =
            addTextView.frame.height
            + projectsTableView.intrinsicContentSize.height
            + Constants.spacer
            + Constants.contentInset * 2
    }
    
    // MARK: - View Configuration
    
    private func configureSubviews() {
        addTextView.textField.becomeFirstResponder()
        addTextView.textField.placeholder = "Add New Project"
        addTextView.delegate = self
        
        projectsTableView.set(cornerRadius: 10)
      
        projectsTableView.pin(super: contentView)
            .top(Constants.contentInset)
            .sides(Constants.contentInset)
            .activate
        
        addTextView.pin(super: contentView)
            .below(projectsTableView, Constants.spacer)
            .sides(Constants.contentInset)
            .bottom(Constants.contentInset)
            .activate
    }
    
    private func updateContentHeight() {
        contentHeight = [projectsTableView, addTextView]
            .map { $0.frame.height }
            .withAppend(Constants.contentInset * 2,
                        Constants.spacer)
            .reduce(0, +)
    }
}

extension ProjectPickerViewController: AddTextDelegate {
    func add(text: String?) {
        if let projectName = text,
            let projectViewModel = viewModel.addProject(withName: projectName) {
            selectAndDismiss(project: projectViewModel)
        } else {
            showAlert(title: "Wrong Project Name",
                      message: viewModel.wrongNameMessage)
        }
    }
    
    private func selectAndDismiss(project: ProjectViewModel) {
        delegate?.didSelect(project: project)
        remove()
    }
}

// MARK: - UITableViewDelegate

extension ProjectPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectAndDismiss(project: tableViewModel.projects[indexPath.row])
    }
}
