//
//  TabButtonViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 02.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

struct TabButtonViewModel: TabBarButtonViewModel {
    let tab: Tab
    
    var icon: UIImage? { UIImage(named: "\(basePath)-\(tab.rawValue)") }
    var iconSize: CGSize { CGSize(width: 30, height: 30) }
    var backgroundColor: UIColor? { nil }
}
