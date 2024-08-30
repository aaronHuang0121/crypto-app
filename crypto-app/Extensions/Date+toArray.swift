//
//  Date+toArray.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/30.
//

import Foundation

extension Date {
    func toArray(byAdding value: Int, count: Int) -> [Date] {
        guard let startDate = Calendar.current.date(byAdding: .day, value: value, to: self), count > 2 else {
            return Array(repeating: self, count: count)
        }

        let step = (self.timeIntervalSince1970 - startDate.timeIntervalSince1970) / Double(count - 1)
        return (0..<count)
            .map({ index in
                Date(timeIntervalSince1970: startDate.timeIntervalSince1970 + Double(index) * step)
            })
    }
}
