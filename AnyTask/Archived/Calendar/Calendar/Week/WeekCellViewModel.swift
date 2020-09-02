//
//  WeekCellViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

struct WeekCellViewModel {
    private let date: Date
    let sideAnchor = CGFloat(10)
    
    init (date: Date) {
        self.date = date
    }
    
    var dayViewModels: [DayViewModel] {
        date.week(start: .monday).map { DayViewModel(date: $0) }
    }
}
