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
        static let buttonSize: CGFloat = 60
        static let buttonOffset: CGFloat = 16
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
        var bottomContentInset = Constants.buttonSize + Constants.buttonOffset
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
        view.backgroundColor = Color.light
        
        projectsViewController.delegate = self
        insertProjectsView()
        
        add(button: Button.with(type: .plus),
            action: #selector(addTask),
            pin: { $0.size(Constants.buttonSize)
                .bottom(Constants.buttonOffset)
                .right(Constants.buttonOffset) })
        
//        add(button: Button.with(type: .pomodoro),
//            action: #selector(pomodoroAction),
//            pin: { $0.size(Constants.buttonSize)
//                .bottom(Constants.buttonOffset)
//                .left(Constants.buttonOffset) })
    }

    
    // MARK: - View Configuration
    
    private func insertProjectsView() {
        self.insert(projectsViewController, at: 0)
        projectsView.pin.allSafe().activate
    }
    
    private func add(button: UIButton, action: Selector, pin: (Pin)->(Pin)) {
        button.addTarget(self, action: action, for: .touchUpInside)
        pin(button.pin(super: view)).activate
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
                addTaskViewModel.add(projectVM: selectedProject)
            }
        }
        let addTaskViewController = AddTaskViewController(addTaskViewModel)
        add(addTaskViewController, frame: view.frame)
    }
}

// MARK: - ProjectsViewControllerDelegate

extension ContentView: ProjectsViewControllerDelegate {
    func didSelect(projectVM projectViewModel: ProjectViewModel) {
        selectedProject = projectViewModel
        selectedProject?.delegate = self
        
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

extension ContentView: ProjectViewModelDelegate {
    func edit(taskVM: TaskViewModel) {
//        showNotImplementedAlert()
    }
    
    func update() {
        projectViewController?.reloadData()
    }
}
