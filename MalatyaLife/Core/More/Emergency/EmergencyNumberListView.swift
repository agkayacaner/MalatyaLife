//
//  EmergencyNumberListView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct EmergencyNumberListView: View {
    @StateObject var viewModel = EmergencyViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.emergencyList, id:\.self) { emergency in
                Button(action: {
                    guard let url = URL(string: "tel://\(emergency.phone)") else { return }
                    UIApplication.shared.open(url)
                }, label: {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text(emergency.title)
                    }
                })
            }
        }
        .refreshable {
            Task {
                do {
                    try await viewModel.fetchEmergencyNumbers()
                } catch {
                    print("An error occurred: \(error)")
                }
            }
        }
        .task {
            do {
                try await viewModel.fetchEmergencyNumbers()
            } catch {
                print("An error occurred: \(error)")
            }
        }
        .listStyle(.plain)
        .navigationTitle("Önemli Telefonlar")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        EmergencyNumberListView()
    }
}
