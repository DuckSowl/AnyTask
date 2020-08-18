//
//  AddTaskViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 16.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

protocol AddTaskViewModelDelegate: AnyObject {
    func itemsDidChange()
}

class AddTaskViewModel {
    
    // MARK: - Properties
    
    let projectViewModel: ProjectViewModel?
    
    weak var delegate: AddTaskViewModelDelegate?
    
    var items = AddTaskCollectionItemModel.ItemType.allCases.map {
        AddTaskCollectionItemViewModel(.init(type: $0,
                                             chosen: Bool.random(),
                                             comment: "\($0.rawValue)"))
        } {
        didSet {
            delegate?.itemsDidChange()
        }
    }
    
    static let maxTitleLength = 128
    
    // MARK: - Initializers
    
    init(_ viewModel: ProjectViewModel?) {
        projectViewModel = viewModel
    }
}
