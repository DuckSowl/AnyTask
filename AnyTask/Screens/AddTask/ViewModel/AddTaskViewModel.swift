//
//  AddTaskViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 16.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol AddTaskViewModelDelegate: AnyObject {
    func itemsDidChange()
}

class AddTaskViewModel {
    
    // MARK: - Constants
    
    static let minTitleLength = 6
    static let maxTitleLength = 128
    
    // MARK: - Properties
    
    let projectsViewModel: ProjectsViewModel
    
    weak var delegate: AddTaskViewModelDelegate?
    
    var items: [AddTaskCollectionItemViewModel] {
        [.init(type: .project,
               chosen: project != nil,
               comment: project?.name ?? ""),
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
    
    private var project: ProjectViewModel?
    private var commentAdded = false
    private var deadline: Date?
    
    // MARK: - Initializers
    
    init(_ viewModel: ProjectsViewModel) {
        projectsViewModel = viewModel
    }
    
    // MARK: - Methods

    func add(project: ProjectViewModel) {
        self.project = project
        delegate?.itemsDidChange()
    }
    
    func add(deadline: Date) {
        self.deadline = deadline
        delegate?.itemsDidChange()
    }
    
    func addComment() {
        commentAdded = true
        delegate?.itemsDidChange()
    }
    
    func addTask(title: String, comment: String?) -> Bool {
        if (Self.minTitleLength...Self.maxTitleLength).contains(title.count) {
            let task = Task(title: title, comment: comment, deadline: deadline,
                            project: project?.project, time: .init())
            projectsViewModel.projectDataManager.taskDataManager.add(task)
            return true
        }
        return false
    }
    
    var wrongLengthAlertMessage: String {
        "Title should be from \(Self.minTitleLength) " +
        "to \(Self.maxTitleLength)."
    }
}
