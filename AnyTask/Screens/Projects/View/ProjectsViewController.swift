//
//  ProjectsViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

final class ProjectsViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cellId = "projectCell"
        
        static let additionalInset: CGFloat = 10
        static let backgroundInset: CGFloat = 10
        static let addProjectButtonCompactSidesConstant: CGFloat = 65
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - Properties
    
    weak var delegate: ProjectsViewControllerDelegate?
    
    private let viewModel: ProjectsViewModel
    
    private let contentInsets: VerticalInsets
    private let lastSection: Int

    // MARK: - Subviews
    
    private let topBarView = TopBarView()
    
    private let projectsTableView: ProjectsTableView
    private let backgroundViews: [UIView]
    
    private let bottomFooterView = UIView()
    private let addProjectButton = Button.with(type: .text("Add Project"))
    
    // MARK: - Initializers
    
    init(_ viewModel: ProjectsViewModel, bottomContentInset: CGFloat) {
        self.viewModel = viewModel
        projectsTableView = ProjectsTableView(viewModel.tableViewModel(withStyle: .all))
        lastSection = projectsTableView.numberOfSections - 1
        
        backgroundViews = (0...lastSection).map { _ in UIView() }
        
        contentInsets =
            .init(top: topBarView.contentHeight + Constants.additionalInset,
                  bottom: bottomContentInset + Constants.additionalInset)
        
        super.init(nibName: nil, bundle: nil)
        
//        (1...10).forEach { viewModel.projectDataManager.add(.init(name: "New \($0)"))}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = UIView()
        
        viewModel.delegate = self
        
        configureSubviews()
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureBackgroundViewFrames()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureAddProjectButtonConstraints()
    }

    // MARK: - View Configuration
    
    private func configureSubviews() {
        projectsTableView.delegate = self
        projectsTableView.backgroundColor = .clear
        projectsTableView.showsVerticalScrollIndicator = false
        
        addProjectButton.backgroundColor = .red
        addProjectButton.addTarget(self, action: #selector(addProject),
                                   for: .touchUpInside)
        
        backgroundViews.forEach {
            // TODO: Rework to Color manager
            if #available(iOS 13.0, *) {
                $0.backgroundColor = .systemGray6
            }
            
            $0.set(cornerRadius: Constants.cornerRadius)
            view.addSubview($0)
        }
    }
    
    private var isAddProjectButtonCompact = false {
        willSet {
            if isAddProjectButtonCompact != newValue {
                configureAddProjectButtonSideConstraints(compact: newValue)
            }
        }
    }
    
    private func configureConstraints() {
        projectsTableView.pin(super: view)
            .top().bottomSafe().sides(Constants.backgroundInset * 2)
            .activate
        
        topBarView.pin(super: view)
            .top().sides()
            .activate
        
        addProjectButton.pin(super: bottomFooterView)
            .top(Constants.backgroundInset)
            .sides()
            .activate
    }
    
    private func configureAddProjectButtonSideConstraints(compact: Bool) {
        UIView.animate(withDuration: 0.3) {
            let constant: CGFloat = compact
                ? Constants.addProjectButtonCompactSidesConstant
                : 0
            
            self.addProjectButton.getConstraint(for: .left)?.constant = constant
            self.addProjectButton.getConstraint(for: .right)?.constant = -constant
            
            self.view.layoutIfNeeded()
        }
    }
    
    private func configureBackgroundViewFrames() {
        (0...projectsTableView.numberOfSections - 1).forEach {
            var newFrame = projectsTableView.convert(projectsTableView.rect(forSection: $0),
                                                     to: UIScreen.main.fixedCoordinateSpace)
            newFrame.origin.x -= Constants.backgroundInset
            newFrame.size.width += Constants.backgroundInset * 2
            
            newFrame.origin.y += $0 == 0 ? contentInsets.top
                : Constants.backgroundInset * 2
            newFrame.size.height -= $0 == 0
                ? contentInsets.top - Constants.backgroundInset
                : contentInsets.bottom - addProjectButton.frame.height
                + Constants.backgroundInset * 2
            
            backgroundViews[$0].frame = newFrame
        }
    }
    
    private func configureAddProjectButtonConstraints() {
        let offset = projectsTableView.convert(projectsTableView.rect(forSection: 1),
                                               to: bottomFooterView).maxY - bottomFooterView.frame.height
        
        let buttonHeight = addProjectButton.frame.height
        isAddProjectButtonCompact = offset > Constants.backgroundInset * 1.5
        addProjectButton.getConstraint(for: .top)?.constant =
            offset < buttonHeight + Constants.backgroundInset * 2
            ? offset + Constants.backgroundInset
            : buttonHeight + Constants.backgroundInset * 3
    }
    
    
    
    // MARK: - Actions
    
    @objc private func addProject() {
        let projectPickerViewController =
            ProjectPickerViewController(viewModel)
        add(projectPickerViewController, frame: view.bounds)
    }
    
}

// MARK: - UITableViewDelegate

extension ProjectsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(projectVM: projectsTableView.project(at: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? contentInsets.top + Constants.backgroundInset
                     : Constants.backgroundInset * 3
    }
    
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        section == lastSection ? bottomFooterView : UIView()
    }
    
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        section == lastSection ? contentInsets.bottom + Constants.backgroundInset * 2 : 0
    }
}

// MARK: - UIScrollViewDelegate

extension ProjectsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        configureBackgroundViewFrames()
        configureAddProjectButtonConstraints()
    }
}

// MARK: - ProjectsDelegate

extension ProjectsViewController: ProjectsDelegate {
    func didSelect(project: ProjectViewModel) {
        showAlert(title: "didSelect", message: project.name)
    }
    
    func update() {
        view.layoutIfNeeded()
        projectsTableView.reloadData()
        view.layoutIfNeeded()
        configureBackgroundViewFrames()
    }
}
