//
//  MyExpenseApp.swift
//  MyExpense
//
//  Created by Iqbal Alhadad on 15/12/25.
//

import SwiftUI
import SwiftData

@main
struct MyExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
      .modelContainer(for: [Transaction.self])
    }
}
