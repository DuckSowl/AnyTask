//
//  TaskViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 14.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

struct TaskViewModel {
    let task: Task
    
    var title: String { task.title }
    var comment: String { task.comment }
    var deadline: String { task.deadline?.description ?? "No deadline" }
    var project: String { task.project.name }
    var estimatedTime: String { "\(task.time.expected ?? 0)" }
    
    static let titleFont = UIFont.preferredFont(forTextStyle: .title3).roundedIfAvailable()
    static let smallFont = UIFont.preferredFont(forTextStyle: .subheadline).roundedIfAvailable()
    
    static let sideAnchor = CGFloat(15)
    static let topAnchor = CGFloat(10)
    static let bottomAnchor = CGFloat(10)
    static let backgroundInsets = UIEdgeInsets(top: 5, leading: 10,
                                               bottom: -5, trailing: -10)
    static let cornerRadius = CGFloat(14)
}
