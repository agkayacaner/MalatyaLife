//
//  EarthquakeListView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct EarthquakeListView: View {
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(1..<4) { earthquake in
                        EarthquakeCellView()
                    }
                }
                .listStyle(.plain)
            }
            
            // Loading View
        }
        .navigationTitle("Son Depremler").navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        EarthquakeListView()
    }
}
