//
//  CampaignView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.02.2024.
//

import SwiftUI

struct AnnouncementView: View {
    @StateObject var viewModel = AnnouncementViewModel()
    
    var body: some View {
        NavigationStack {
                List {
                    ForEach(viewModel.gruppedAnnouncements.keys.sorted(), id:\.self) { key in
                        Section(header: Text(viewModel.formatDate(key))) {
                            ForEach(viewModel.gruppedAnnouncements[key]!) { announcement in
                                NavigationLink {
                                    AnnouncementDetailsView(announcement: announcement)
                                } label: {
                                    AnnouncementCell(announcement: announcement)
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Etkinlik ve Duyurular")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        AnnouncementView()
    }
}
