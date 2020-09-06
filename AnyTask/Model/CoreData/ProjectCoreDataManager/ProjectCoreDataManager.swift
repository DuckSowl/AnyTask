//
//  ProjectCoreDataManager.swift
//  AnyTask
//
//  Created by Anton Tolstov on 30.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import CoreData

final class ProjectCoreDataManager: CoreDataManager<ProjectMO, Project> {
    let taskDataManager: TaskCoreDataManager
    
    override init?() {
        guard let taskDataManager = TaskCoreDataManager() else {
            return nil
        }
        
        self.taskDataManager = taskDataManager
        
        super.init()
        
        taskDataManager.projectCoreDataManager = self
    }
}

// MARK: - DataManageable

extension ProjectCoreDataManager: DataManageable {
    func add(_ project: Project) {
        let newProjectMO = ProjectMO(context: context)
        newProjectMO.id = project.id.data
        newProjectMO.title = project.name
        
        saveContext()
    }
    
    func update(_ project: Project) {
        guard let oldProject = fetch(with: project.id) else { return }
        oldProject.title = project.name
        
        saveContext()
    }
}
