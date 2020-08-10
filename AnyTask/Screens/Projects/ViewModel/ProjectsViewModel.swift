//
//  ProjectsViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

protocol ProjectsDelegate: AnyObject {
    func didSelect(project: ProjectViewModel)
}

class ProjectsViewModel {
    
    // MARK: - Properties
    
    var projectDataManager: ProjectCoreDataManager
    
    weak var delegate: ProjectsDelegate?
    
    // MARK: - Initializers
    
    init(_ projectDataManager: ProjectCoreDataManager) {
        self.projectDataManager = projectDataManager
    }
    
    // MARK: - View Model
    
    private(set) lazy var permanentProjects: [ProjectViewModel] = PermanentProjects.allCases.map {
        ProjectViewModel(project: Project(id: UUID(),
                                          name: $0.rawValue),
                         taskDataManager: projectDataManager.taskDataManager)
    }
    
    var projects: [ProjectViewModel] {
        projectDataManager.getAll().map { ProjectViewModel(project: $0, taskDataManager: projectDataManager.taskDataManager) }
    }
}

// TODO: - Rework as ProjectVM subclass

enum PermanentProjects: String, CaseIterable {
    case today = "Today"
    case upcoming = "Upcoming"
    case inbox = "Inbox"
}
