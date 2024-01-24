//
//  AuthService.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email:String, password:String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func createUser(withEmail email:String, name:String, lastname:String, password:String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(withEmail: email, name: name, lastname: lastname, id: result.user.uid)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func uploadUserData(withEmail email:String, name:String, lastname:String, id:String) async throws {
        let user = User(id: id, name: name, lastname: lastname, email: email, createdAt: Date().timeIntervalSince1970)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
    }
}
