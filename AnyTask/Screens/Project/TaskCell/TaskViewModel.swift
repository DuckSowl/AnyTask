//
//  TaskViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 14.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol TaskViewModelDelegate: UpdateDelegate {
    func edit(taskVM: TaskViewModel)
}

struct TaskViewModel {
    
    // MARK: - Style
    
    enum Style {
        case normal
        case noProject
        case noDeadline
    }
    
    // MARK: - Properties
    
    weak var delegate: TaskViewModelDelegate?
    
    // MARK: - Private Properties
    
    let task: Task
    private let taskDataManager: TaskCoreDataManager
    
    // MARK: - Initializers
    
    init(task: Task, taskDataManager: TaskCoreDataManager, style: Style = .normal) {
        self.task = task
        self.taskDataManager = taskDataManager
        self.style = style
    }
    
    // MARK: - View Model
    
    let style: Style
    var title: String { task.title }
    var comment: String? { task.comment }
    
    var project: String {
        style != .noProject ? (task.project?.name ?? "Inbox") : ""
    }
    
    var deadline: String {
        style != .noDeadline ? task.deadline?.formatted ?? "No deadline" : ""
    }
        
    var estimatedTime: String { "\(notNil: task.time.expected)" }
    
    func delete() {
        taskDataManager.delete(task)
        delegate?.update()
    }
    
    func complete() {
        var newTask = task
        newTask.completed = true
        taskDataManager.update(newTask)
        delegate?.update()
    }
    
    func edit() {
        delegate?.edit(taskVM: self)
    }
}
