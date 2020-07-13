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
    var comment: String
    
    var deadline: Date?
    var project: Project
    
    var completed: Bool
    
    var time: Time
    
    internal init(title: String, comment: String, deadline: Date? = nil, project: Project, completed: Bool, time: Task.Time) {
        self.id = UUID()
        self.title = title
        self.comment = comment
        self.deadline = deadline
        self.project = project
        self.completed = completed
        self.time = time
    }
}

extension Task {
    struct Time {
        var expected: UInt?
        var spent: UInt?
    }
}
