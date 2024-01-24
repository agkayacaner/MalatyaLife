//
//  ContentView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var appState = AppState()
    
    var body: some View {
        Group {
            if !appState.isOnboardingDone {
                OnboardingView()
                    .environmentObject(appState)
            } else if !appState.isLoggedIn {
                MainTabView()
            } else {
                MainTabView()
            }
        }
    }
}

#Preview {
    MainTabView()
}
