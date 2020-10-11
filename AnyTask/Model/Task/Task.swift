//
//  Task.swift
//  AnyTask
//
//  Created by Anton Tolstov on 30.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

struct Task: Identifiable {
    let id: UUID
    
    var title: String
    var comment: String?
    
    var deadline: Date?
    var project: Project?
    
    var completed: Bool
    
    var time: Time
    
    internal init(id: UUID = UUID(), title: String, comment: String?,
                  deadline: Date? = nil, project: Project?,
                  completed: Bool = false, time: Task.Time) {
        self.id = id
        self.title = title
        self.comment = comment
        self.deadline = deadline
        self.project = project
        self.completed = completed
        self.time = time
    }
    
//    #if DEBUG
//    static var example: Task {
//        Task(title: Array(repeating: "This is example title. ",
//                          count: Int.random(in: 1...3)).joined(),
//             comment: Array(repeating: "This is example comment. ",
//                            count: Int.random(in: 1...10)).joined(),
//             deadline: Calendar.current.date(byAdding: .hour,
//                                             value: Int.random(in: -100...100),
//                                             to: Date()) ,
//        project: Project(name: "Development"),
//             completed: false,
//             time: Time(expected: UInt.random(in: 1...10)))
//    }
//    #endif
}

extension Task {
    struct Time {
        var expected: UInt?
        var spent: UInt?
    }
}
