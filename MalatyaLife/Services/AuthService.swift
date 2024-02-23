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
    
    @Published var userSession: Firebase.User?
    
    static let shared = AuthService()
    
    init() {
        guard let currentUser = Auth.auth().currentUser, currentUser.isEmailVerified else { return }
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email:String, password:String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            guard result.user.isEmailVerified else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "E-posta adresi doğrulanmamış. Lütfen e-posta adresinizi doğrulayın."])
            }
            
            self.userSession = result.user
            UserService.shared.fetchCurrentUser()
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func createUser(withEmail email:String, name:String, lastname:String, password:String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await uploadUserData(withEmail: email, name: name, lastname: lastname, id: result.user.uid)
            
            try await result.user.sendEmailVerification()
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw error
        }
    }
    
    @MainActor
    func uploadUserData(withEmail email:String, name:String, lastname:String, id:String) async throws {
        let user = User(id: id, name: name, lastname: lastname, email: email, businesses: [], createdAt: Date())
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        UserService.shared.currentUser = user
    }
    
    func resendVerifyEmail() async throws {
        do {
            guard let currentUser = Auth.auth().currentUser else { return }
            try await currentUser.sendEmailVerification()
        } catch {
            throw error
        }
    }
    
    func resetPassword(withEmail email:String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            throw error
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.reset()
    }
}
