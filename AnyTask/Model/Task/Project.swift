//
//  Project.swift
//  AnyTask
//
//  Created by Anton Tolstov on 30.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

struct Project: Identifiable {
    let id: UUID
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    
    var name: String
}
