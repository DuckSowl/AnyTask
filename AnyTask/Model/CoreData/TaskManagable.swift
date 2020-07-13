//
//  TaskManagable.swift
//  AnyTask
//
//  Created by Anton Tolstov on 13.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

protocol TaskManagable {
    func addTask(task: Task)     // C
    func getAllTasks() -> [Task] // R
    func update(task: Task)      // U
    func delete(task: Task)      // D
}
