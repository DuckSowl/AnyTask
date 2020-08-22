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
    
    let viewModel: ProjectsViewModel
    
    // MARK: - Initializers
    
    init(_ viewModel: ProjectsViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero, style: .plain)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        }
        dataSource = self
        register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellId)
        tableFooterView = UIView()
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

// MARK: - UITableViewDataSource

extension ProjectsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath)
        
        cell.textLabel?.text = viewModel.projects[indexPath.row].name
        
        return cell
    }
}

