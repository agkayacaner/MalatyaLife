//
//  PharmacyListView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct PharmacyListView: View {
    @State var isPresented = false
    
    var body: some View {
        List {
            Section("\(Date.getCurrentDate()) Nöbetçi Eczaneler") {
                ForEach(1..<4) { pharmacy in
                    Button {
                        isPresented.toggle()
                    } label: {
                        PharmacyCellView()
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Eczaneler")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isPresented, content: {
            PharmacyDetailView()
                .presentationDetents([.medium])
        })
    }
}

#Preview {
    NavigationStack {
        PharmacyListView()
    }
}
