//
//  ProjectsTableView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 22.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class ProjectsTableView: UITableView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cellId = "projectCell"
    }
    
    // MARK: - Properties
    
    let viewModel: ProjectsTableViewModel
    
    // MARK: - Initializers
    
    init(_ viewModel: ProjectsTableViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero, style: .plain)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Intrinsic content size
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        dataSource = self
        register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellId)
        tableFooterView = UIView()
    }
    
    // MARK: - Private Methods
    
    func project(at indexPath: IndexPath) -> ProjectViewModel {
        (indexPath.section == 0
            ? viewModel.style == .all
                ? viewModel.permanentProjects
                : (viewModel.projects as [ProjectViewModel])
            : viewModel.projects
        )[indexPath.row]
    }
}

// MARK: - UITableViewDataSource

extension ProjectsTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.style == .all ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0  {
            return viewModel.style == .all
                ? viewModel.permanentProjects.count
                : viewModel.projects.count
        }
        return viewModel.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId,
                                                 for: indexPath)

        cell.textLabel?.text = project(at: indexPath).name
        cell.backgroundColor = Color.clear
        cell.set(cornerRadius: viewModel.style == .all ? 10 : 0)
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        viewModel.style == .all && indexPath.section == 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let projectVM = project(at: indexPath) as? UserDefinedProjectViewModel {
                viewModel.delete(projectVM: projectVM)
            }
        }
    }
}

