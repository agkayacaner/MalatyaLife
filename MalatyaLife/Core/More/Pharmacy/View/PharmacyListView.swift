//
//  PharmacyListView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct PharmacyListView: View {
    @StateObject var viewModel = PharmacyViewModel()
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            List {
                Section("\(Date.getCurrentDate()) Nöbetçi Eczaneler") {
                    ForEach(viewModel.pharmacies.flatMap(\.data)) { pharmacy in
                        Button {
                            viewModel.selectedPharmacy = pharmacy
                            isPresented.toggle()
                        } label: {
                            PharmacyCellView(pharmacy: pharmacy)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .refreshable {
                await viewModel.getAllPharmacies()
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .task {
            await viewModel.getAllPharmacies()
        }
        .navigationTitle("Eczaneler")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isPresented, content: {
            PharmacyDetailView(pharmacy: viewModel.selectedPharmacy!)
                .presentationDetents([.medium])
        })
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.primaryButton)
        }
    }
}

#Preview {
    NavigationStack {
        PharmacyListView()
    }
}
