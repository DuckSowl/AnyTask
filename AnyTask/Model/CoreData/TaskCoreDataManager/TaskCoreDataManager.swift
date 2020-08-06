//
//  TaskCoreDataManager.swift
//  AnyTask
//
//  Created by Anton Tolstov on 11.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import CoreData

final class TaskCoreDataManager: CoreDataManager<TaskMO, Task> { }

// MARK: - DataManageable

extension TaskCoreDataManager: DataManageable {
    func add(_ task: Task) {
        let newTaskMO = TaskMO(context: context)
        newTaskMO.id = task.id.data
        newTaskMO.title = task.title
        newTaskMO.comment = task.comment
        newTaskMO.deadline = task.deadline
        newTaskMO.completed = task.completed
        newTaskMO.expectedTime = task.time.expectedForMO
        newTaskMO.spentTime = task.time.spentForMO
        
        saveContext()
    }
    
    func update(_ newTask: Task) {
        guard let oldTask = fetch(with: newTask.id) else { return }
        oldTask.title = newTask.title
        oldTask.comment = newTask.comment
        oldTask.deadline = newTask.deadline
        oldTask.completed = newTask.completed
        oldTask.expectedTime = newTask.time.expectedForMO
        oldTask.spentTime = newTask.time.spentForMO
        
        saveContext()
    }
}
