//
//  TabViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 29.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit
import Pin

class ContentView: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let buttonSize = CGSize(width: 60, height: 60)
        static let bottomConstant: CGFloat = 16
    }
    
    // MARK: - View Model
    
    let viewModel: ContentViewModel
    
    // MARK: - Subviews
    
    private lazy var projectsViewController =
        ProjectsViewController(viewModel.projectsViewModel,
                               bottomContentInset: bottomContentInset)
    
    private var projectsView: UIView { projectsViewController.view }
    
    private var projectViewController: ProjectViewController!
    
    private var selectedProject: ProjectViewModel?
    
    var bottomContentInset: CGFloat {
        var bottomContentInset = Constants.buttonSize.height + Constants.bottomConstant
        if #available(iOS 11.0, *) {
            bottomContentInset -= view.safeAreaInsets.bottom
        }
        return bottomContentInset
    }
    
    // MARK: - Initializers
    
    init(_ viewModel: ContentViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        projectsViewController.delegate = self
        insertProjectsView()
        
        // TODO: Remove code repetitions
        let addButton = Button.with(type: .plus)
        addButton.addTarget(self, action: #selector(addTask),
                            for: .touchUpInside)
        
        addButton.pin(super: view)
            .size(60).bottom(16).right(16)
            .activate
        
        let pomodoroButton = Button.with(type: .pomodoro)
        pomodoroButton.addTarget(self, action: #selector(pomodoroAction),
                            for: .touchUpInside)
        
        pomodoroButton.pin(super: view)
            .size(60).bottom(16).left(16)
            .activate
    }
    
    // MARK: - View Configuration
    
    private func insertProjectsView() {
        self.insert(projectsViewController, at: 0)
        projectsView.pin.allSafe().activate
    }
    
    // MARK: - Actions
    
    @objc func addTask() {
        var addTaskViewModel = AddTaskViewModel(viewModel.projectsViewModel)
        addTaskViewModel.delegate = self
        if let selectedProject = selectedProject {
            if let permanentProjectViewModel = selectedProject as? PermanentProjectViewModel {
                if permanentProjectViewModel.kind == .today {
                    addTaskViewModel.add(deadline: Date())
                }
            } else {
                addTaskViewModel.add(project: selectedProject)
            }
        }
        let addTaskViewController = AddTaskViewController(addTaskViewModel)
        add(addTaskViewController, frame: view.frame)
    }
    
    @objc func pomodoroAction() {
        notImplementedAlert()
    }
}

// MARK: - ProjectsViewControllerDelegate

extension ContentView: ProjectsViewControllerDelegate {
    func didSelect(projectVM projectViewModel: ProjectViewModel) {
        selectedProject = projectViewModel
        
        projectViewController =
            ProjectViewController(projectViewModel,
                                  bottomContentInset: bottomContentInset)
        
        guard let projectViewController = projectViewController else { return }
        projectViewController.delegate = self
        insert(projectViewController, at: 1)
        
        projectViewController.topBarView.alpha = 0
        projectViewController.tableView.transform =
            .init(translationX: view.frame.width, y: 0)
                
        UIView.animate(withDuration: 0.5, animations: {
            self.projectsView.alpha = 0
            
            projectViewController.topBarView.alpha = 1
            projectViewController.tableView.transform = .identity
        }, completion: { _ in self.projectsViewController.remove() })
    }
}

// MARK: - BackDelegate

extension ContentView: ProjectViewControllerDelegate {
    func back() {
        insertProjectsView()
        
        selectedProject = nil
        
        UIView.animate(withDuration: 0.5, animations: {
            self.projectsView.alpha = 1
            self.projectViewController.tableView.transform =
                .init(translationX: self.view.frame.width, y: 0)
        }, completion:  { _ in self.projectViewController.remove() })
    }
}

extension ContentView: AddTaskDelegate {
    func taskAdded() {
        projectViewController?.reloadData()
    }
}

