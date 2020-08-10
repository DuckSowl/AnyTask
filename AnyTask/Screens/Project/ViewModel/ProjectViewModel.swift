//
//  ProjectViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

struct ProjectViewModel {
    
    // MARK: - Properties
    
    private let project: Project
    private let taskDataManager: TaskCoreDataManager
    
    weak var backDelegate: ProjectsDelegate?
    
    // MARK: - Initializers
    
    init(project: Project, taskDataManager: TaskCoreDataManager) {
        self.taskDataManager = taskDataManager
        
        self.project = project
    }
    
    // MARK: - View Model
    
    var name: String { project.name }
    
    var color: UIColor { Color.random }
    
    var tasks: [TaskCellViewModel] {
        taskDataManager.getAll(for: project).map { TaskCellViewModel(task: $0) }
    }
}
