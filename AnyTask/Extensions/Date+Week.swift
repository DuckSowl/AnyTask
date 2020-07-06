//
//  Date+Week.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

extension Date {
    func week(start weekStart: WeekStart) -> [Date] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        
        guard
            let firstDayOfWeekGTM0 = calendar.dateInterval(of: .weekOfYear,
                                                             for: startOfDay)?.start,
            var firstDayOfWeek = calendar.date(byAdding: .second,
                                               value: TimeZone.current.secondsFromGMT(),
                                               to: firstDayOfWeekGTM0)
            else { // Calendar can't make this date manipulations
                return []
        }
        
        if weekStart == .monday {
            firstDayOfWeek = calendar.date(byAdding: .day, value: 1,
                                           to: firstDayOfWeek) ?? startOfDay
        }
            
        return (0...6).map {
            calendar.date(byAdding: .day, value: $0, to: firstDayOfWeek) ?? firstDayOfWeek
        }
    }
    
    enum WeekStart {
        case sunday, monday
    }
}
