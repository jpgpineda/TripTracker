//
//  Date+Ext.swift
//  TripTracker
//
//  Created by javier pineda on 13/05/24.
//

import Foundation

extension Date {
    func getPostedDate() -> String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        return String(format: "%d-%d", month, year)
    }
}
