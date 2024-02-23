//
//  ProfileViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 25.01.2024.
//

import Firebase
import Combine
import FirebaseAuth

final class ProfileViewModel: ObservableObject {
    
    @Published var currentUser: User?
    @Published var businesses =  [Business]()
    @Published var announcements =  [Announcement]()
    @Published var selectedAnnouncement: Announcement?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task {
            do {
                guard let currentUser = Auth.auth().currentUser, currentUser.isEmailVerified else { return }
                try await getUserData()
                try await fetchBusinesses()
                try await fetchAnnouncements()
            } catch {
                print("DEBUG: Error getting user data \(error.localizedDescription)")
            }
        }
    }
    
    @MainActor
    private func getUserData() async throws {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
    }
    
    @MainActor
    func fetchBusinesses() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("businesses")
            .whereField("ownerUID", isEqualTo: uid)
            .order(by: "createdAt",descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self?.businesses = documents.compactMap { queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: Business.self)
                }
            }
    }
    
    @MainActor
    func fetchAnnouncements() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("announcements")
            .whereField("ownerUID", isEqualTo: uid)
            .order(by: "createdAt",descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self?.announcements = documents.compactMap { queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: Announcement.self)
                }
            }
    }
    
    func businessStatusControl() -> Bool {
        businesses.filter({ $0.isApproved }).count > 0
    }
}
