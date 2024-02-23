//
//  UserAnnouncementsView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 23.02.2024.
//

import SwiftUI

struct UserAnnouncementsView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.announcements) { announcement in
                    if announcement.isActive {
                        Button {
                            isPresented.toggle()
                            viewModel.selectedAnnouncement = announcement
                        } label: {
                            AnnouncementCell(announcement: announcement)
                        }
                    } else {
                        ZStack {
                            AnnouncementCell(announcement: announcement)
                                .opacity(0.5)
                            
                            HStack {
                                Spacer()
                                
                                Text("Aktif Değil")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.vertical,4)
                                    .padding(.horizontal)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .sheet(isPresented: $isPresented, content: {
                VStack(alignment:.leading, spacing: 10) {
                    HStack {
                        Text(viewModel.selectedAnnouncement!.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    HStack(spacing:10) {
                        Text(AnnouncementViewModel().showAnnouncementDate(announcement: viewModel.selectedAnnouncement!))
                        
                        if viewModel.selectedAnnouncement!.category != "İndirim" {
                            Text(viewModel.selectedAnnouncement!.startDate, style: .time)
                                .foregroundStyle(.primary).bold()
                        }
                    }
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    
                    Divider()
                    
                    Text(viewModel.selectedAnnouncement!.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .padding()
                .presentationDetents([.medium])
            })
            .navigationTitle("Etkinlik ve Duyurularım")
        }
    }
}

#Preview {
    UserAnnouncementsView()
}
