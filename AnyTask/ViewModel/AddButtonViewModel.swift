//
//  AddButtonViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 02.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

struct AddButtonViewModel: TabBarButtonViewModel {
    var icon: UIImage? { UIImage(named: "\(basePath)-plus") }
    var iconSize: CGSize { CGSize(width: 50, height: 50) }
    var backgroundColor: UIColor? { .red }
}
