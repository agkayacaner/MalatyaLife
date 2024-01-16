//
//  MainTabView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedTab = 0
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label("Keşfet", systemImage: selectedTab == 0 ?  "doc.text.image.fill" : "doc.text.image")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear { selectedTab = 0 }
                .tag(0)
            
            EventsView()
                .tabItem {
                    Label("Etkinlikler", systemImage: selectedTab == 1 ? "theatermasks.fill" : "theatermasks")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                }
                .onAppear { selectedTab = 1 }
                .tag(1)
            
            SearchView()
                .tabItem {
                    Label("Ara", systemImage: "magnifyingglass")
                }
                .onAppear { selectedTab = 2 }
                .tag(2)
            
            
            MoreView()
                .tabItem {
                    Label("Daha Fazla", systemImage: selectedTab == 3 ? "bolt.horizontal.fill" : "bolt.horizontal")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear { selectedTab = 3 }
                .tag(3)
        }
    }
}

#Preview {
    MainTabView()
}
