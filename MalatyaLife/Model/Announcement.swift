//
//  Announcement.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.02.2024.
//

import Firebase
import FirebaseFirestoreSwift

struct Announcement: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var category: String
    var startDate: Date
    var endDate: Date
    var businessID: String
    var ownerUID: String
    var isActive: Bool = false
    var isApproved: Bool = false
    var createdAt: Date = Date()
    
    enum Category: String, CaseIterable {
        case select = "Seçiniz"
        case event = "Etkinlik"
        case music = "Canlı Müzik"
        case discount = "İndirim"
    }
}


struct AnnouncementMockData {
    static let sampleAnnouncement01 = Announcement(id: "1", name: "Duyuru Başlığı", description: "Duyuru Açıklaması", category: "İndirim" ,startDate: Date(), endDate: Date(), businessID: "apdf1d3kıfhy71nad4", ownerUID: "o9nfjad812da" ,isActive: true, isApproved: true)
}
