//
//  AddTaskCollectionItemViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 18.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

struct AddTaskCollectionItemViewModel {
    
    // MARK: - Properties
    
    private var model: AddTaskCollectionItemModel
    
    // MARK: - Initializers
    
    init(_ model: AddTaskCollectionItemModel) {
        self.model = model
    }
    
    // MARK: - View Model
    
    var image: UIImage? { UIImage(named: model.type.rawValue) }
    
    var chosen: Bool {
        get { model.chosen }
        set { model.chosen = newValue }
    }
    
    var comment: String { model.chosen ? model.comment : "" }
    
    var type: AddTaskCollectionItemModel.ItemType { return model.type }
}


