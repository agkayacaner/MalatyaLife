//
//  EarthquakeListView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct EarthquakeListView: View {
    @StateObject var viewModel = EarthquakeViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(viewModel.earthquakes) { earthquake in
                        EarthquakeCellView(earthquake: earthquake)
                    }
                }
                .refreshable {
                    await viewModel.fetchEarthquakes()
                }
                .listStyle(.plain)
            }

            if viewModel.isLoading {
                LoadingView()
            }
        }
        .task {
            await viewModel.fetchEarthquakes()
        }
        .navigationTitle("Son Depremler").navigationBarTitleDisplayMode(.large)
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        
    }
}

#Preview {
    NavigationStack {
        EarthquakeListView()
    }
}
