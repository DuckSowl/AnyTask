//
//  TaskCoreDataManager.swift
//  AnyTask
//
//  Created by Anton Tolstov on 11.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit
import CoreData

final class TaskCoreDataManager {
    
    // MARK: - Properties
    
    private let context: NSManagedObjectContext
    private let saveContext: () -> ()
    
    // MARK: - Initializers
    
    init?() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        context = delegate.persistentContainer.viewContext
        saveContext = delegate.saveContext
    }
    
    // MARK: - Private Methods
    
    private func fetchAll() -> [TaskMO]? {
        let fetchRequest: NSFetchRequest<TaskMO> = TaskMO.fetchRequest()
        return try? context.fetch(fetchRequest)
    }
    
    private func fetchTask(with id: UUID) -> TaskMO? {
        guard let tasks = fetchAll() else { return nil }
        return tasks.first(where: { $0.id?.unsafeUUID() == id })
    }
}

// MARK: - TaskManagable

extension TaskCoreDataManager: TaskManagable {
    func addTask(task: Task) {
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
    
    func getAllTasks() -> [Task] {
        let tasks = fetchAll() ?? []
        return tasks.map { Task(taskMO: $0) }
    }
    
    func update(task newTask: Task) {
        guard let oldTask = fetchTask(with: newTask.id) else { return }
        oldTask.title = newTask.title
        oldTask.comment = newTask.comment
        oldTask.deadline = newTask.deadline
        oldTask.completed = newTask.completed
        oldTask.expectedTime = newTask.time.expectedForMO
        oldTask.spentTime = newTask.time.spentForMO
        
        saveContext()
    }
    
    func delete(task: Task) {
        guard let task = fetchTask(with: task.id) else { return }
        context.delete(task)
        
        saveContext()
    }
}

// MARK: Extensions

fileprivate extension Task {
    init(taskMO: TaskMO) {
        id = taskMO.id!.unsafeUUID()
        title = taskMO.title!
        comment = taskMO.comment!
        deadline = taskMO.deadline
        project = Project(name: "[NotImplemented]")
        completed = taskMO.completed
        time = Time(expected: taskMO.expectedTime,
                    spent: taskMO.spentTime)
    }
}

fileprivate extension Task.Time {
    var expectedForMO: Int32 { expected.int32OrMinusOne }
    var spentForMO: Int32 { spent.int32OrMinusOne }
    
    init(expected: Int32, spent: Int32) {
        self.init(expected: (expected != -1) ? (UInt)(expected) : nil,
                  spent: (spent != -1) ? (UInt)(spent) : nil)
    }
}

fileprivate extension Optional where Wrapped == UInt {
    var int32OrMinusOne: Int32 {
        return (self != nil && self! < Int32.max) ? (Int32)(self!) : -1
    }
}

