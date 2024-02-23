//
//  CampaignViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.02.2024.
//

import Firebase
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class AnnouncementViewModel: ObservableObject {
    @Published var announcements: [Announcement] = []
    @Published var gruppedAnnouncements: [Date: [Announcement]] = [:]
    @Published var businesses: [String: Business] = [:]
    
    @Published var isLoading: Bool = false
    
    init() {
        Task {
            try await fetchAnnouncements()
        }
    }
    
    @MainActor
    func fetchAnnouncements() async throws  {
        do {
            isLoading = true
            AnnouncementService.shared.fetchAnnouncements { [weak self] announcements in
                self?.announcements = announcements
                self?.gruppedAnnouncements = Dictionary(grouping: announcements, by: { announcement in
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.year, .month, .day], from: announcement.startDate)
                    return calendar.date(from: components) ?? announcement.startDate
                })
                
                for announcement in announcements {
                    BusinessService.shared.fetchBusiness(withID: announcement.businessID) { business in
                        self?.businesses[announcement.businessID] = business
                    }
                }
                
                self?.isLoading = false
            }
        }
    }

    
    func announcementDuration(startDate: Date, endDate: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.maximumUnitCount = 2
        return formatter.string(from: startDate, to: endDate)!
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "tr_TR")
        return dateFormatter.string(from: date)
    }
    
    func formatDateDay(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "tr_TR")
        return dateFormatter.string(from: date)
    }
 
    func showAnnouncementDate(announcement: Announcement) -> String {
        let selectedCampaignStartDate = formatDate(announcement.startDate)
        let selectedCampaignEndDate = formatDate(announcement.endDate)
        
        if selectedCampaignStartDate == selectedCampaignEndDate {
            return "\(selectedCampaignStartDate)"
        } else {
            return "\(selectedCampaignStartDate) - \(selectedCampaignEndDate)"
        }
    }
    
    func getSystemImageName(for category: String) -> String {
        switch category {
        case "Canlı Müzik":
            return "music.mic"
        case "Etkinlik":
            return "calendar"
        case "İndirim":
            return "tag"
        default:
            return "circle.fill"
        }
    }
}
