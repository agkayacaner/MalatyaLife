//
//  EmergencyService.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import Foundation
import Firebase

class EmergencyService {
    
    static let shared = EmergencyService()
    
    init() {}
    
    let db = Firestore.firestore()
    
    func fetchBusinesses() async throws -> [Emergency] {
        let querySnapshot = try await db.collection("emergencies").order(by: "title").getDocuments()
        let emegergencies = querySnapshot.documents.compactMap { document in
            try? document.data(as: Emergency.self)
        }
        return emegergencies
    }
    
}
