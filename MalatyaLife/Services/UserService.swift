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
        Task { await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let user = try? document.data(as: User.self) else {
                print("Error decoding user: \(error!)")
                return
            }
            self.currentUser = user
        }
    }

    
//    @MainActor
//    func fetchCurrentUser() async throws {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
//        let user = try snapshot.data(as: User.self)
//        self.currentUser = user
//    }
        
    func fetchUser(withID id: String, completion: @escaping (User) -> Void) {
        Firestore.firestore().collection("users").document(id).getDocument { (document, error) in
            if let document = document, document.exists {
                if let user = try? document.data(as: User.self) {
                    completion(user)
                }
            }
        }
    }
    
    func reset(){
        self.currentUser = nil
    }
    
}
