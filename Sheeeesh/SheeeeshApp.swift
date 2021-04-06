//
//  SheeeeshApp.swift
//  Sheeeesh
//
//  Created by Kevin Laminto on 5/4/21.
//

import SwiftUI

@main
struct SheeeeshApp: App {
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .environmentObject(homeViewModel)
                    .tabItem {
                        Label("For you", systemImage: "heart.text.square")
                    }
                SavedMemesView()
                    .environmentObject(homeViewModel)
                    .tabItem {
                        Label("Saved", systemImage: "heart.fill")
                    }
            }
        }
    }
}
