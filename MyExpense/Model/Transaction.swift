//
//  Transaction.swift
//  MyExpense
//
//  Created by Iqbal Alhadad on 15/12/25.
//

import SwiftUI


struct Transaction: Identifiable {
    let id:UUID = .init()
    //Properties
    let title:String
    var remarks:String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor:String
    
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    //extract color value from tintcolor string
    var color: Color {
        return tints.first(where: {
            $0.color == tintColor
        })?.value ?? appTint
    }
}


//sample transactions for UI Building

