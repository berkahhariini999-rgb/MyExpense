//
//  ChartModel.swift
//  MyExpense
//
//  Created by Iqbal Alhadad on 17/12/25.
//

import SwiftUI

struct ChartGroup: Identifiable {
    let id: UUID = .init()
    var date: Date
    var categories: [ChartCategory]
    var totalIncome: Double
    var totalExpense: Double
    
}

struct ChartCategory: Identifiable {
    let id: UUID = .init()
    var totalValue: Double
    var category: Category
}


