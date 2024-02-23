//
//  EarthquakeListView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

public enum EarthquakeSorter: Hashable {
    case afad
    case kandilli
}

struct EarthquakeListView: View {
    @StateObject var viewModel = EarthquakeViewModel()
    @State private var sort = EarthquakeSorter.afad
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(viewModel.earthquakes.flatMap(\.data).prefix(50), id: \.self) { earthquake in
                        Button(action: {
                            viewModel.selectedEarthquake = earthquake
                            viewModel.showDetail = true
                        }, label: {
                            EarthquakeCellView(earthquake: earthquake)
                        })
                    }
                }
                .onChange(of: sort) { _ in
                    switch sort {
                    case .afad:
                        viewModel.earthquakes = []
                        Task {
                            await viewModel.fetchFromAfad()
                        }
                    case .kandilli:
                        viewModel.earthquakes = []
                        Task {
                            await viewModel.fetchFromKandilli()
                        }
                    }
                }
                .refreshable {
                    switch sort {
                    case .afad:
                        await viewModel.fetchFromAfad()
                    case .kandilli:
                        await viewModel.fetchFromKandilli()
                    }
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
            switch sort {
            case .afad:
                await viewModel.fetchFromAfad()
            case .kandilli:
                await viewModel.fetchFromKandilli()
            }
        }
        .navigationTitle("Son Depremler: " + viewModel.earthquakeFrom).navigationBarTitleDisplayMode(.inline)
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.primaryButton)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                toolbarItems
            }
        }
    }
    
    @ViewBuilder
    private var toolbarItems: some View {
        Menu {
            Picker("Sort", selection: $sort) {
                Label("Afad", systemImage: "a.circle")
                    .tag(EarthquakeSorter.afad)
                Label("Kandilli", systemImage: "k.circle")
                    .tag(EarthquakeSorter.kandilli)
            }
        } label: {
            Label("Kaynak", image: "globe.europe.africa.badge.gearshape.fill")
        }
    }
}


#Preview {
    NavigationStack {
        EarthquakeListView()
    }
}
