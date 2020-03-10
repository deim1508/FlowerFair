//
//  DateFormatter.swift
//  FlowerFair
//
//  Created by Rebeka on 23/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import Foundation

extension Date {
    static func formatDateFromInt(dateInt: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(dateInt))
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
