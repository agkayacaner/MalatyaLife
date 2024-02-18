//
//  Event.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 14.02.2024.
//

import Firebase
import FirebaseFirestoreSwift

struct Event: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var image: String?
    var createdAt: TimeInterval
    var isFeatured: Bool
}

struct EventMockData {
    static let events = [
        Event(id: "1", name: "Event 1", description: "Event 1 Description", image: "https://www.biletix.com/static/images/live/event/groupimages/atademirerr-grup-gorselll.jpg", createdAt: Date().timeIntervalSince1970, isFeatured: true),
    ]
}
