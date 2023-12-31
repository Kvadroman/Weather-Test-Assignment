//
//  UIDate+String.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 14.06.2023.
//

import UIKit

extension Date {
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: self)
    }
    
    func convertToHours() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    func isSameDay(as otherDate: Date) -> Bool {
        let dateComponentsSelf = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let dateComponentsOther = Calendar.current.dateComponents([.year, .month, .day], from: otherDate)
        
        return dateComponentsSelf.year == dateComponentsOther.year &&
        dateComponentsSelf.month == dateComponentsOther.month &&
        dateComponentsSelf.day == dateComponentsOther.day
    }
}
