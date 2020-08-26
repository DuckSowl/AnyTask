//
//  TaskViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 14.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

struct TaskViewModel {
    
    // MARK: - Properties
    
    let task: Task
    
    // MARK: - View Model
    
    var title: String { task.title }
    var comment: String? { task.comment }
    var deadline: String { task.deadline?.formatted ?? "No deadline" }
    var project: String { task.project?.name ?? "Inbox" }
    var estimatedTime: String { "\(notNil: task.time.expected)" }
    
    // TODO: - Move to font manager
    
    static let titleFont = UIFont.preferredFont(forTextStyle: .title3).roundedIfAvailable()
    static let smallFont = UIFont.preferredFont(forTextStyle: .subheadline).roundedIfAvailable()
    
    // TODO: - Move constants to view
    
    static let sideAnchor = CGFloat(15)
    static let topAnchor = CGFloat(10)
    static let bottomAnchor = CGFloat(10)
    static let backgroundSides = CGFloat(10)
    static let backgroundTopButton = CGFloat(5)
    static let cornerRadius = CGFloat(14)
}
