//
//  ContentView.swift
//  MyExpense
//
//  Created by Iqbal Alhadad on 15/12/25.
//

import SwiftUI

struct ContentView: View {
    //intro visibility status
    @AppStorage("isFirstTime") private var isFirstTime:Bool = true
    //active tab
    @State private var activeTab: Tab = .recents
    var body: some View {
        TabView(selection: $activeTab) {
            Recent()
            //Text("Recents")
                .tag(Tab.recents)
                .tabItem {
                    Tab.recents.tabContent
                }
            Search()
            //Text("Search")
                .tag(Tab.search)
                .tabItem {
                    Tab.search.tabContent
                }
            Graphs()
            //Text("Chart")
                .tag(Tab.charts)
                .tabItem {
                    Tab.charts.tabContent
                }
            Settings()
            //Text("Settings")
                .tag(Tab.settings)
                .tabItem {
                    Tab.settings.tabContent
                }
                .tint(appTint)
                .sheet(isPresented: $isFirstTime, content:  {
                    IntroScreen()
                        .interactiveDismissDisabled()
                })
        }
      
    }
}

#Preview {
    ContentView()
}
