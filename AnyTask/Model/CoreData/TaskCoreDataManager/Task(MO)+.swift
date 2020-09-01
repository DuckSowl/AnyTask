//
//  Task(MO)+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

// MARK: Task Extensions

extension Task: IdentifiableObject { }

extension Task: ManagedObjectInitializable {
    init(managedObject taskMO: TaskMO) {
        id = taskMO.id.unsafeUUID()
        title = taskMO.title
        comment = taskMO.comment
        deadline = taskMO.deadline
        if let projectMO = taskMO.project {
            project = Project(managedObject: projectMO)
        }
        completed = taskMO.completed
        time = Time(expected: taskMO.expectedTime,
                    spent: taskMO.spentTime)
    }
}

// MARK: TaskMO Extensions

extension TaskMO: IdentifiableObject {
   typealias IdentityType = Data
}

// MARK: Time Extensions

extension Task.Time {
    var expectedForMO: Int32 { expected.int32OrMinusOne }
    var spentForMO: Int32 { spent.int32OrMinusOne }
    
    init(expected: Int32, spent: Int32) {
        self.init(expected: (expected != -1) ? (UInt)(expected) : nil,
                  spent: (spent != -1) ? (UInt)(spent) : nil)
    }
}

// MARK: Optional(UInt) Fileprivate Extensions

fileprivate extension Optional where Wrapped == UInt {
    var int32OrMinusOne: Int32 {
        return (self != nil && self! < Int32.max) ? (Int32)(self!) : -1
    }
}
