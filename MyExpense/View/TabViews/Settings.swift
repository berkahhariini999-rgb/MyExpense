//
//  Settings.swift
//  MyExpense
//
//  Created by Iqbal Alhadad on 15/12/25.
//

import SwiftUI

struct Settings: View {
    @AppStorage("userName") private var userName:String = ""
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled:Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground:Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section("User Name") {
                    TextField("IqbalAlhadad", text: $userName)
                }
                
                
                Section("App Lock"){
                    Toggle("Enable App Lock", isOn: $isAppLockEnabled)
                    
                    if isAppLockEnabled {
                        Toggle("Lock When App Goes Background", isOn: $lockWhenAppGoesBackground)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    ContentView()
}
