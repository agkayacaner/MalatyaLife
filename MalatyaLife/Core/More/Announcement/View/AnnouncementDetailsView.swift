//
//  announcementDetailsView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.02.2024.
//

import SwiftUI

struct AnnouncementDetailsView: View {
    @State var announcement: Announcement
    @StateObject var viewModel = AnnouncementViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment:.leading, spacing: 10) {
                HStack {
                    Text(announcement.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                
                HStack(spacing:10) {
                    Text(viewModel.showAnnouncementDate(announcement: announcement))
                    
                    if announcement.category != "İndirim" {
                        Text(announcement.startDate, style: .time)
                            .foregroundStyle(.primary).bold()
                    }
                }
                .font(.callout)
                .foregroundStyle(.secondary)
                
                Divider()
                
                Text(announcement.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                
                if let business = viewModel.businesses[announcement.businessID] {
                    VStack {
                        NavigationLink {
                            BusinessDetailView(business: business).navigationBarBackButtonHidden(true)
                        } label: {
                            BusinessCell(business: business)
                        }
                        
                    }
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(14)
                }
            }
            .padding()
        }
    }
}

