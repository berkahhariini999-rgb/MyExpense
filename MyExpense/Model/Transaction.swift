//
//  Transaction.swift
//  MyExpense
//
//  Created by Iqbal Alhadad on 15/12/25.
//

import SwiftUI
import SwiftData

@Model
class Transaction {
   // let id:UUID = .init()
    //Properties
    var title:String
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
    
    @Transient
    var color: Color {
        return tints.first(where: {
            $0.color == tintColor
        })?.value ?? appTint
    }
    
    @Transient
    var tint: TintColor? {
        return tints.first(where: {
            $0.color == tintColor
        })
    }
    
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: {
            category == $0.rawValue
        })
    }
}


//sample transactions for UI Building
//var sampleTransactions: [Transaction] = [
//    .init(title: "Magic Keyboard", remarks: "Apple Product", amount: 1200000, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
//    .init(title: "Apple Music", remarks: "Subscription", amount: 30000, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
//    .init(title: "iCloud", remarks: "Subscription", amount: 15000, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
//    .init(title: "Payment", remarks: "Payment Received", amount: 24000, dateAdded: .now, category: .income, tintColor: tints.randomElement()!),
//]
