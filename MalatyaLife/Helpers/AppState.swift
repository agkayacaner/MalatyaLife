//
//  AppState.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import SwiftUI
import Combine
import Firebase
import FirebaseAuth

enum AppStorageKey: String {
    case isOnboardingDone
    case isLoggedIn

}

final class AppState: ObservableObject {
    @AppStorage(AppStorageKey.isOnboardingDone.rawValue) var isOnboardingDone: Bool = false
    @AppStorage(AppStorageKey.isLoggedIn.rawValue) var isLoggedIn: Bool = false
    @Published var userSession: Firebase.User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscriptions()
        Task {
            await logoutUserFirstRun()
        }
    }
    
    @MainActor
    func logoutUserFirstRun() {
        if !isOnboardingDone {
            AuthService.shared.signOut()
        }
    }
    
    private func setupSubscriptions() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            if userSession == nil {
                self?.userSession = nil
                self?.isLoggedIn = false
            } else {
                self?.userSession = userSession
                self?.isLoggedIn = true
            }
        }
        .store(in: &cancellables)
    }
}
