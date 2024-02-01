//
//  ExploreViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 23.01.2024.
//

import Firebase
import FirebaseFirestoreSwift

final class ExploreViewModel: ObservableObject {
    @Published var featuredBusinesses : [Business] = []
    @Published var latestBusinesses : [Business] = []
    @Published var selectedBusiness : Business?
    
    init() {
        Task {
            fetchFeaturedBusinessesListen()
            fetchLatestBusinessesListen()
        }
    }
    
    let db = Firestore.firestore()
    
    func fetchFeaturedBusinessesListen() {
        listenToCollection(collection: "businesses", field: "isFeatured", isEqualTo: true) { businesses in
            self.featuredBusinesses = businesses
        }
    }
    
    func fetchLatestBusinessesListen() {
        listenToCollection(collection: "businesses", field: "isApproved", isEqualTo: true) { businesses in
            self.latestBusinesses = businesses
        }
    }
    
    func listenToCollection(collection: String, field: String, isEqualTo: Bool, completion: @escaping ([Business]) -> Void) {
        db.collection(collection)
            .whereField("isApproved", isEqualTo: true)
            .whereField(field, isEqualTo: isEqualTo)
            .order(by: "timestamp",descending: true)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                let businesses = documents.compactMap { queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: Business.self)
                }
                completion(businesses)
            }
    }
}
