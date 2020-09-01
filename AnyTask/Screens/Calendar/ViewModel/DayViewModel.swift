//
//  DayViewModel.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

struct DayViewModel {
    private let date: Date
    
    init(date: Date) {
        self.date = date
    }
    
    let cornerRadius = CGFloat(18)
    let backgroundColor = Color.gray
    
    let widthAnchorConstant = CGFloat(36)
    let stackInsets = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
    
    let weekSymbolFontSize = CGFloat(15)
    let dateStringFontSize = CGFloat(12)
    
    var dateString: String { "\(Calendar.current.component(.day, from: date))" }
    var weekSymbol: String {
        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = "EEEEE" // First letter of weekday
        return dateFormetter.string(from: date)
    }
}
