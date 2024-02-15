//  Date+Extension.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 07/10/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

extension Date {

    mutating func addHour(_ hour: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hour, to: self)!
    }

    func setHour(hour: Int) -> Date? {
        var calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: self)

        components.hour = hour
        components.minute = .zero
        components.second = .zero

        guard let timeZone = TimeZone(abbreviation: "UTC") else { return Date() }

        calendar.timeZone = timeZone
        return calendar.date(from: components)
    }
}
