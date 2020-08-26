//
//  ProjectViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol ProjectViewModel {
    var name: String { get}
    var tasks: [TaskViewModel] { get }
    
    func addTask(title: String, comment: String?, deadline: Date?, time: Task.Time)
}

class ProjectViewModelDataManager {
    
    // MARK: - Properties
    
    fileprivate let projectDataManager: ProjectCoreDataManager
    
    // MARK: - Initializers
    
    fileprivate init(projectDataManager: ProjectCoreDataManager) {
        self.projectDataManager = projectDataManager
    }
    
    // MARK: - View Model
    
    fileprivate func tasks(for project: Project?) -> [TaskViewModel] {
        projectDataManager.taskDataManager
            .getAll(for: project).map { TaskViewModel(task: $0) }
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
        case upcoming  = "Upcoming"
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
        switch kind {
            case .today:
                return projectDataManager.taskDataManager.getAll().filter {
                    $0.deadline != nil ? $0.deadline! < Date().addingTimeInterval(.init(10000)) : false
                }.map { TaskViewModel(task: $0) }
            case .all:
                return projectDataManager.taskDataManager.getAll().map {
                    TaskViewModel(task: $0)
            }
            case .upcoming:
                return []
            case .noProject:
                return super.tasks(for: nil)
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
