//
//  ProjectsViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cellId = "projectsCell"
        
        static let additionalInset: CGFloat = 5
    }
    
    private let contentInsets: VerticalInsets
    
    // MARK: - Properties
    
    let viewModel: ProjectsViewModel
    
    weak var delegate: ProjectsViewControllerDelegate?
    
    // MARK: - Subviews
    
    let topBarView = TopBarView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    // MARK: - Initializers
    
    init(_ viewModel: ProjectsViewModel, bottomContentInset: CGFloat) {
        self.viewModel = viewModel
        
        contentInsets =
            .init(top: topBarView.contentHeight + Constants.additionalInset,
                  bottom: bottomContentInset + Constants.additionalInset)
        
        super.init(nibName: nil, bundle: nil)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func configureSubviews() {
        tableView.backgroundColor = .clear
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: Constants.cellId)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        tableView.pin(superView: view).all().activate
        topBarView.pin(superView: view).top(to: view).sides().activate
    }
    
    // MARK: - Private Methods
    
    private func project(at indexPath: IndexPath) -> ProjectViewModel {
        (indexPath.section == 0 ? viewModel.permanentProjects
            : viewModel.projects)[indexPath.row]
    }
}

// MARK: - UITableViewDelegate

extension ProjectsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(project: project(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? contentInsets.top : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == 1 ? contentInsets.bottom : 0
    }
}

// MARK: - UITableViewDataSource

extension ProjectsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (section == 0 ? viewModel.permanentProjects : viewModel.projects).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath)
        
        let projects = indexPath.section == 0 ? viewModel.permanentProjects : viewModel.projects
        
        cell.textLabel?.text = projects[indexPath.row].name
        
        return cell
    }
}
