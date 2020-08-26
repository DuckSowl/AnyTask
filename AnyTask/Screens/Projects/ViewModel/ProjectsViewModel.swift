//
//  ProjectsViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

protocol ProjectsDelegate: UpdateDelegate { }

class ProjectsViewModel {
    
    // MARK: - Constants
    
    let projectNameLengthRange = 6...32
    
    // MARK: - Properties
    
    weak var delegate: ProjectsDelegate?
    let nilProject: PermanentProjectViewModel
    
    // MARK: - Private Properties
    
    private var projectDataManager: ProjectCoreDataManager
    
    // MARK: - Initializers
    
    init(_ projectDataManager: ProjectCoreDataManager) {
        self.projectDataManager = projectDataManager
        nilProject = .init(.noProject, projectDataManager: projectDataManager)
    }
    
    func tableViewModel(withStyle style: ProjectsTableViewModel.Style)
        -> ProjectsTableViewModel {
        let tableViewModel = ProjectsTableViewModel(style: style, projectDataManager: projectDataManager)
        tableViewModel.delegate = self
        return tableViewModel
    }
    
    // MARK: - View Model
    
    func addProject(withName projectName: String) -> UserDefinedProjectViewModel? {
        if projectNameLengthRange.contains(projectName.count) {
            let project = Project(name: projectName)
            projectDataManager.add(project)
            delegate?.update()
            return UserDefinedProjectViewModel(project: project,
                                               projectDataManager: projectDataManager)
        }
        return nil
    }
    
    var wrongNameMessage: String {
        .object("Project", shouldBeInRange: projectNameLengthRange)
    }
}

extension ProjectsViewModel: ProjectsTableDelegate {
    func delete(projectVM: UserDefinedProjectViewModel) {
        projectVM.delete()
        delegate?.update()
    }
}
