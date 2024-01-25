//
//  UserService.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 25.01.2024.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    func reset(){
        self.currentUser = nil
    }
    
}
