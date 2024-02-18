//
//  EventView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct EventsView: View {
    @StateObject var viewModel = EventViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.events) { event in
                NavigationLink(destination: EventDetailView(event: event)) {
                    EventCellView(event: event)
                }
                .foregroundStyle(.primary)
            }
            .listStyle(.plain)
            .navigationTitle("Etkinlikler")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    NavigationStack {
        EventsView()
    }
}
