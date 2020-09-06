//
//  TaskItemViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 18.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

struct TaskItemViewModel {
    
    // MARK: - Properties
    
    private var model: TaskItem
    
    // MARK: - Initializers
    
    init(_ model: TaskItem) {
        self.model = model
    }
    
    // MARK: - View Model
    
    var image: UIImage? { UIImage(named: model.type.rawValue) }
    
    var chosen: Bool {
        get { model.chosen }
        set { model.chosen = newValue }
    }
    
    var comment: String { model.chosen ? model.comment : "" }
    
    var type: TaskItem.ItemType { return model.type }
}
