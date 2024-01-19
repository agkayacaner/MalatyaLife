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
            ForEach(viewModel.emergencyList, id:\.self) { number in
                Button(action: {
                    guard let url = URL(string: "tel://\(number.number)") else { return }
                    UIApplication.shared.open(url)
                }, label: {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text(number.title)
                    }
                })
            }
        }
        .refreshable {
            viewModel.fetchEmergencyNumbers()
        }
        .task {
            viewModel.fetchEmergencyNumbers()
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
