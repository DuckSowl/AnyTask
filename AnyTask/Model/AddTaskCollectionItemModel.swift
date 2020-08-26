//
//  AddTaskCollectionItemModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 18.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

struct AddTaskCollectionItemModel {
    let type: ItemType
    var chosen: Bool
    var comment: String
    
    enum ItemType: String, CaseIterable {
        case project
        case comment
        case deadline
        case pomodoro
        case notification
    }
}
