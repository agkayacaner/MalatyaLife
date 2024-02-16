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
    
    func createBusiness(_ business: Business) async throws {
        guard let businessData = try? Firestore.Encoder().encode(business) else { return }
        try await db.collection("businesses").addDocument(data: businessData)
    }
    
    func createNewBusiness(_ business: Business) async throws {
        guard let businessData = try? Firestore.Encoder().encode(business) else { return }
        let docRef = try await db.collection("businesses").addDocument(data: businessData)
        
        let categoryQuery = db.collection("categories").whereField("name", isEqualTo: business.category)
        let categories = try await categoryQuery.getDocuments()
        
        if let categoryDoc = categories.documents.first, var category = try? categoryDoc.data(as: Category.self) {
            category.businesses.append(docRef.documentID)
            try  categoryDoc.reference.setData(from: category)
        } else {
            let newCategory = Category(name: business.category, businesses: [docRef.documentID])
            try db.collection("categories").addDocument(from: newCategory)
        }
    }
    
    func fetchBusinesses() async throws -> [Business] {
        let querySnapshot = try await db.collection("businesses").whereField("isActive", isEqualTo: true).getDocuments()
        var businesses = querySnapshot.documents.compactMap { document in
            try? document.data(as: Business.self)
        }
        businesses.sort(by: { compareTimestamps($0.timestamp, $1.timestamp) })
        return businesses
    }
    
    func fetchFeaturedBusinesses() async throws -> [Business] {
        let querySnapshot = try await db.collection("businesses")
            .whereField("isActive", isEqualTo: true)
            .whereField("isApproved", isEqualTo: true)
            .whereField("isFeatured", isEqualTo: true)
            .getDocuments()
        return querySnapshot.documents.compactMap { document in
            try? document.data(as: Business.self)
        }
    }
    
    func compareTimestamps(_ t1: Timestamp, _ t2: Timestamp) -> Bool {
        let time1 = t1.dateValue().timeIntervalSince1970
        let time2 = t2.dateValue().timeIntervalSince1970
        return time1 > time2
    }
}
