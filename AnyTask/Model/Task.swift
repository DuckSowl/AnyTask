//
//  Task.swift
//  AnyTask
//
//  Created by Anton Tolstov on 30.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    
    var title: String
    var comment: String
    
    var deadline: Date?
    var project: Project
    
    var completed: Bool
    
    var time: Time
}

extension Task {
    struct Time {
        var expected: UInt?
        var spent: UInt?
    }
}
