//
//  ProjectsTableViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 24.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol ProjectsTableDelegate: Delegate {
    func delete(projectVM: UserDefinedProjectViewModel)
}

final class ProjectsTableViewModel {
    
    // MARK: - Constants
    
    enum Style {
        case all
        case onlyUserDefined
    }
    
    // MARK: - Properties
    
    weak var delegate: ProjectsTableDelegate?
    
    // MARK: - Private Properties
    
    private let projectDataManager: ProjectCoreDataManager
    
    // MARK: - View Model
    
    let style: Style
    
    let permanentProjects: [PermanentProjectViewModel]
    
    var projects: [UserDefinedProjectViewModel] {
        projectDataManager.getAll().map {
            .init(project: $0, projectDataManager: projectDataManager)
        }
    }
    
    // MARK: - Initializers
    
    init(style: Style, projectDataManager: ProjectCoreDataManager) {
        self.style = style
        self.projectDataManager = projectDataManager
        
        permanentProjects = PermanentProjectViewModel
            .all(projectDataManager: projectDataManager)
    }
    
    // MARK: - Private Methods

    func delete(projectVM: UserDefinedProjectViewModel) {
        delegate?.delete(projectVM: projectVM)
    }
}
