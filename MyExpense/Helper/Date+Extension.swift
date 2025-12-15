//
//  Date+Extension.swift
//  MyExpense
//
//  Created by Iqbal Alhadad on 15/12/25.
//

import SwiftUI

extension Date {
    var startofMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return calendar.date(from: components) ?? self
    }
    
    var endofMonth: Date {
        let calendar = Calendar.current
        
        return calendar.date(byAdding: .init(month: 1, minute: -1), to: self.startofMonth) ?? self
    }
}
