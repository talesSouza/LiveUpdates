//
//  Date+Extensions.swift
//  LiveUpdates
//
//  Created by Tales Souza on 08/11/23.
//

import SwiftUI

extension Date {
    
    func toString(dateFormat: String = "MM/dd", timeFormat: String = "HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "\(dateFormat) - \(timeFormat)"
        return dateFormatter.string(from: self)
    }
}
