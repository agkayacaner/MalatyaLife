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
                    ForEach(viewModel.earthquakes.flatMap(\.data)) { earthquake in
                        
                        Button(action: {
                            viewModel.selectedEarthquake = earthquake
                            viewModel.showDetail = true
                        }, label: {
                            EarthquakeCellView(earthquake: earthquake)
                        })
                                            
                    }
                }
                .refreshable {
                    await viewModel.fetchEarthquakes()
                }
                .listStyle(.plain)
            }
            .sheet(isPresented: $viewModel.showDetail, content: {
                EarthquakeDetailView(
                    viewModel: viewModel,
                    earthquake: viewModel.selectedEarthquake!)
                .presentationDetents([.medium,.large])
                    .ignoresSafeArea()
            })

            if viewModel.isLoading {
                LoadingView()
            }
        }
        .task {
            await viewModel.fetchEarthquakes()
        }
        .navigationTitle("Son Depremler").navigationBarTitleDisplayMode(.large)
        /// Filter Button
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                })
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.primaryButton)
        }
        
    }
}

#Preview {
    NavigationStack {
        EarthquakeListView()
    }
}
