//
//  AnnouncementCell.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.02.2024.
//

import SwiftUI

struct AnnouncementCell: View {
    @State var announcement: Announcement
    @StateObject var viewModel = AnnouncementViewModel()
    
    var body: some View {
        HStack {
            Image(systemName: viewModel.getSystemImageName(for: announcement.category))
                .font(.title3)
                .foregroundColor(.accent)
            
            VStack(alignment: .leading) {
                Text(announcement.name)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                
                if let business = viewModel.businesses[announcement.businessID] {
                    Text(business.name)
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            Text(viewModel.formatDateDay(announcement.startDate))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AnnouncementCell(announcement: AnnouncementMockData.sampleAnnouncement01)
        .padding()
}
