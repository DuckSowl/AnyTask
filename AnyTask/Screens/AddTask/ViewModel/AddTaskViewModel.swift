//
//  AddTaskViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 16.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol AddTaskDelegate: Delegate {
    func taskAdded()
}

struct AddTaskViewModel {
    
    // MARK: - Constants
    
    let titleLength = (4...128)
    
    // MARK: - Properties
    
    weak var delegate: AddTaskDelegate?
    
    let projectsViewModel: ProjectsViewModel
        
    var items: [AddTaskCollectionItemViewModel] {
        [.init(type: .project,
               chosen: projectVM != nil,
               comment: projectVM?.name ?? ""),
         commentAdded ? nil :
            .init(type: .comment,
                  chosen: false,
                  comment: ""),
         .init(type: .deadline,
               chosen: deadline != nil,
               comment: deadline != nil ? "\(deadline!.formatted)" : "")]
            .compactMap { $0 }
            .map { .init($0) }
    }
    
    // MARK: - Private Properties
    
    private var projectVM: ProjectViewModel?
    private var commentAdded = false
    private var deadline: Date?
    
    // MARK: - Initializers
    
    init(_ viewModel: ProjectsViewModel) {
        projectsViewModel = viewModel
    }
    
    // MARK: - Methods

    mutating func add(project: ProjectViewModel) {
        self.projectVM = project
    }
    
    mutating func add(deadline: Date) {
        self.deadline = deadline
    }
    
    mutating func addComment() {
        commentAdded = true
    }
    
    func addTask(title: String, comment: String?) -> Bool {
        guard titleLength.contains(title.count) else { return false }
        
        let project = projectVM ?? projectsViewModel.nilProject
        project.addTask(title: title, comment: comment, deadline: deadline, time: .init())
        delegate?.taskAdded()
        return true
    }
    
    var wrongLengthAlertMessage: String {
        "Title should be from \(notNil: titleLength.min()) " +
        "to \(notNil: titleLength.max())."
    }
}
