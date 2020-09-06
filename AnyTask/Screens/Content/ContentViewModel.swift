//
//  ContentViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 08.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

class ContentViewModel {
    
    // MARK: - Properties
    
    let projectDataManager: ProjectCoreDataManager
    
    // MARK: - Initializers
    
    init?() {
        guard let projectDataManager = ProjectCoreDataManager() else {
            return nil
        }
        
        self.projectDataManager = projectDataManager
    }
    
    // MARK: - View Model
    
    lazy var projectsViewModel: ProjectsViewModel = {
        ProjectsViewModel(projectDataManager)
    }()
}
