//
//  ProjectViewSelectionDelegate.swift
//  AnyTask
//
//  Created by Anton Tolstov on 10.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

protocol ProjectViewSelectionDelegate: AnyObject {
    func didSelect(project: ProjectViewModel)
}
