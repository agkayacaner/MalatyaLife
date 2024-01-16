//
//  BusinessService.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct BusinessService {
    
    static let shared = BusinessService()
    
    init() {}
    
    let db = Firestore.firestore()

    func fetchBusinesses() async throws -> [Business] {
        let querySnapshot = try await db.collection("businesses").whereField("isApproved", isEqualTo: true).getDocuments()
        return querySnapshot.documents.compactMap { document in
            try? document.data(as: Business.self)
        }
    }
    
    func fetchFeaturedBusinesses() async throws -> [Business] {
        let querySnapshot = try await db.collection("businesses")
            .whereField("isApproved", isEqualTo: true)
            .whereField("isFeatured", isEqualTo: true)
            .getDocuments()
        return querySnapshot.documents.compactMap { document in
            try? document.data(as: Business.self)
        }
    }
}
