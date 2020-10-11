//
//  ProjectViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol ProjectViewModelDelegate: UpdateDelegate {
    func edit(taskVM: TaskViewModel)
}

protocol ProjectViewModel {
    var name: String { get}
    var tasks: [TaskViewModel] { get }
    
    var delegate: ProjectViewModelDelegate? { get set }
    
    func addTask(title: String, comment: String?, deadline: Date?, time: Task.Time)
}

class ProjectViewModelDataManager {
    
    // MARK: - Properties
    
    fileprivate let projectDataManager: ProjectCoreDataManager
    
    weak var delegate: ProjectViewModelDelegate?
    
    // MARK: - Initializers
    
    fileprivate init(projectDataManager: ProjectCoreDataManager) {
        self.projectDataManager = projectDataManager
    }
    
    // MARK: - View Model
    
    fileprivate func tasks(for project: Project?) -> [TaskViewModel] {
        projectDataManager.taskDataManager
            .getAll(for: project).compactMap {
                guard !$0.completed else { return nil }
                var taskViewModel = TaskViewModel(task: $0,
                                                  taskDataManager: projectDataManager.taskDataManager,
                                                  style: .noProject)
                taskViewModel.delegate = self
                return taskViewModel
        }
    }
    
    fileprivate func addTask(title: String, comment: String?,
                 deadline: Date?, time: Task.Time, project: Project?) {
        projectDataManager.taskDataManager
            .add(Task(title: title, comment: comment, deadline: deadline,
                      project: project, time: time))
    }
}

final class UserDefinedProjectViewModel: ProjectViewModelDataManager, ProjectViewModel {

    // MARK: - Private Properties
    
    private let project: Project
    
    // MARK: - Initializers

    init(project: Project, projectDataManager: ProjectCoreDataManager) {
        self.project = project

        super.init(projectDataManager: projectDataManager)
    }
    
    // MARK: - View Model
    
    var name: String { project.name }
    var tasks: [TaskViewModel] { tasks(for: project) }

    func delete() {
        projectDataManager.delete(project)
    }
    
    func addTask(title: String, comment: String?,
                 deadline: Date?, time: Task.Time) {
        super.addTask(title: title, comment: comment, deadline: deadline,
                      time: time, project: project)
    }
}

final class PermanentProjectViewModel: ProjectViewModelDataManager, ProjectViewModel {
    
    // MARK: - Constants
    
    enum Kind: String, CaseIterable {
        case today     = "Today"
        case all       = "All"
        case noProject = "No Project"
        
    }

    // MARK: - Properties
    
    let kind: Kind
    
    // MARK: - Initializers

    init(_ kind: Kind, projectDataManager: ProjectCoreDataManager) {
        self.kind = kind
        
        super.init(projectDataManager: projectDataManager)
    }

    // MARK: - View Model
    
    var name: String { kind.rawValue }
    var tasks: [TaskViewModel] {
        var tasks: [TaskViewModel]
        switch kind {
            case .today:
                tasks = projectDataManager.taskDataManager.getAll().filter {
                    $0.deadline != nil ? $0.deadline! < Date().addingTimeInterval(.init(10000)) : false
                }.compactMap {
                    guard !$0.completed else { return nil }
                    return .init(task: $0,
                                 taskDataManager: projectDataManager.taskDataManager,
                                 style: .noDeadline)
                }
            case .all:
                tasks = projectDataManager.taskDataManager.getAll().compactMap {
                    guard !$0.completed else { return nil }
                    return .init(task: $0,
                                 taskDataManager: projectDataManager.taskDataManager)
                }
            case .noProject:
                tasks = super.tasks(for: nil)
        }
        
        return tasks.map {
            var task = $0
            task.delegate = self
            return task
        }
    }
    
    func addTask(title: String, comment: String?,
                 deadline: Date?, time: Task.Time) {
        super.addTask(title: title, comment: comment, deadline: deadline,
                      time: time, project: nil)
    }
    
    static func all(projectDataManager: ProjectCoreDataManager) -> [PermanentProjectViewModel] {
        Kind.allCases.map { .init($0, projectDataManager: projectDataManager) }
    }
}

// MARK: - TaskViewModelDelegate

extension ProjectViewModelDataManager: TaskViewModelDelegate {
    func update() {
        delegate?.update()
    }
    
    func edit(taskVM: TaskViewModel) {
        delegate?.edit(taskVM: taskVM)
    }
}
