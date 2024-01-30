//
//  MainTabView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedTab = 0
    @ObservedObject private var appState = AppState()
    
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label("Keşfet", systemImage: selectedTab == 0 ?  "doc.text.image.fill" : "doc.text.image")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear { selectedTab = 0 }
                .tag(0)
            
            NewsListView()
                .tabItem {
                    Label("Gündem", systemImage: selectedTab == 1 ? "newspaper.fill" : "newspaper")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                }
                .onAppear { selectedTab = 1 }
                .tag(1)
            
            EventsView()
                .tabItem {
                    Label("Etkinlikler", systemImage: selectedTab == 2 ? "theatermasks.fill" : "theatermasks")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                }
                .onAppear { selectedTab = 2 }
                .tag(2)
            
            
            SearchView()
                .tabItem {
                    Label("Ara", systemImage: "magnifyingglass")
                }
                .onAppear { selectedTab = 3 }
                .tag(3)
            
            MoreView()
                .environmentObject(appState)
                .tabItem {
                    Label("Daha Fazla", systemImage: selectedTab == 4 ? "bolt.horizontal.fill" : "bolt.horizontal")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
                .onAppear { selectedTab = 4 }
                .tag(4)
        }
    }
}

#Preview {
    MainTabView()
}
