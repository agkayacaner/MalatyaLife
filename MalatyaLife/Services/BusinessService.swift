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
        
        let userDocRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        let userDoc = try await userDocRef.getDocument()
        if var user = try? userDoc.data(as: User.self) {
            user.businesses.append(docRef.documentID)
            try userDocRef.setData(from:user)
        }
    }
    
    func fetchBusinesses() async throws -> [Business] {
        let querySnapshot = try await db.collection("businesses").whereField("isActive", isEqualTo: true).getDocuments()
        var businesses = querySnapshot.documents.compactMap { document in
            try? document.data(as: Business.self)
        }
        businesses.sort { $0.createdAt > $1.createdAt }
        return businesses
    }
    
    func fetchBusiness(withID id: String, completion: @escaping (Business) -> Void) {
        db.collection("businesses").document(id).getDocument { (document, error) in
            if let document = document, document.exists {
                if let business = try? document.data(as: Business.self) {
                    completion(business)
                }
            }
        }
    }
    
    
    // Current userin businesses arrayi içindeki businessleri getirir.
    
    func fetchBusinessCurrentUser(completion: @escaping ([String]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let docRef = Firestore.firestore().collection("users").document(uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let businesses = document.data()?["businesses"] as? [String] {
                    completion(businesses)
                } else {
                    print("No businesses found")
                }
            } else {
                print("Document does not exist")
            }
        }
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
}
