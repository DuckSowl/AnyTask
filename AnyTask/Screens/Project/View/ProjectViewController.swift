//
//  TaskTableViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 14.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol ProjectViewControllerDelegate: BackDelegate { }

class ProjectViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let additionalInset: CGFloat = 5
        static let cellId = "projectCell"
    }
    
    private let contentInsets: VerticalInsets
    
    // MARK: - Properties
    
    let viewModel: ProjectViewModel
    
    weak var delegate: ProjectViewControllerDelegate?
    
    // MARK: - Subviews
    
    let tableView = UITableView()
    
    let topBarView: ProjectTopBarView
    
    // MARK: - Initializers
    
    init(_ viewModel: ProjectViewModel, bottomContentInset: CGFloat) {
        self.viewModel = viewModel
        
        topBarView = ProjectTopBarView(viewModel)
        
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
        topBarView.delegate = self
        
        configureTableView()
        configureConstraints()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TaskCellView.self, forCellReuseIdentifier: Constants.cellId)
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.backgroundColor = Color.clear
        tableView.separatorColor = Color.clear
        
        tableView.scrollIndicatorInsets = .init(top: contentInsets.top - 8 - 5,
                                                left: 0, bottom: 0, right: 0)
    }
    
    private func configureConstraints() {
        tableView.pin(super: view).all().activate
        topBarView.pin(super: view).top().sides().activate
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension ProjectViewController: UITableViewDelegate {
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
        section == tableView.numberOfSections - 1 ? contentInsets.bottom : 0
    }
}

// MARK: - UITableViewDataSource

extension ProjectViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? viewModel.tasks.count : 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId,
                                                 for: indexPath) as! TaskCellView
        
        cell.viewModel = viewModel.tasks[indexPath.row]
        
        return cell
    }
}

extension ProjectViewController: ProjectTopBarDelegate {
    func back() {
        delegate?.back()
    }
}

