//
//  ProfileViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 25.01.2024.
//

import Foundation
import Combine
import FirebaseAuth

final class ProfileViewModel: ObservableObject {
    
    @Published var currentUser: User?
    @Published var businesses =  [Business]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task {
            do {
                guard let currentUser = Auth.auth().currentUser, currentUser.isEmailVerified else { return }
                try await getUserData()
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
}
