//
//  MainTabView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct MainTabView: View {
    @State var activeTab: Tab = .explore
    @ObservedObject private var appState = AppState()
    
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label("Keşfet", systemImage: activeTab == .explore ?  "doc.text.image.fill" : "doc.text.image")
                        .environment(\.symbolVariants, activeTab == .explore ? .fill : .none)
                }
                .onAppear { activeTab = .explore }
                .tag(Tab.explore)
            
            EventsView()
                .tabItem {
                    Label("Etkinlikler", systemImage: activeTab == .events ? "theatermasks.fill" : "theatermasks")
                        .environment(\.symbolVariants, activeTab == .events ? .fill : .none)
                }
                .onAppear { activeTab = .events }
                .tag(Tab.events)
            
            
            SearchView()
                .tabItem {
                    Label("Ara", systemImage: "magnifyingglass")
                }
                .onAppear { activeTab = .search }
                .tag(Tab.search)
            
            MoreView()
                .environmentObject(appState)
                .tabItem {
                    Label("Daha Fazla", systemImage: activeTab == .more ? "bolt.horizontal.fill" : "bolt.horizontal")
                        .environment(\.symbolVariants, activeTab == .more ? .fill : .none)
                }
                .onAppear { activeTab = .more }
                .tag(Tab.more)
        }
        .background(.ultraThinMaterial)
    }
}

enum Tab {
    case explore
    case events
    case search
    case more
}

#Preview {
    MainTabView()
}
