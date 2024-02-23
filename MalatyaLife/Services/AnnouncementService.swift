//
//  CampaingService.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.02.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct AnnouncementService {
    
    static let shared = AnnouncementService()
    
    init() {}
    
    let db = Firestore.firestore()

    func fetchAnnouncements(completion: @escaping ([Announcement]) -> Void) {
        db.collection("announcements")
            .whereField("isActive", isEqualTo: true)
            .whereField("isApproved", isEqualTo: true)
            .order(by: "createdAt",descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                let announcements = documents.compactMap { queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: Announcement.self)
                }
                completion(announcements)
            }
    }
    
    func createAnnouncement(_ announcement: Announcement) async throws {
        guard let announcementData = try? Firestore.Encoder().encode(announcement) else { return }
        _ = try await db.collection("announcements").addDocument(data: announcementData)
    }

}
