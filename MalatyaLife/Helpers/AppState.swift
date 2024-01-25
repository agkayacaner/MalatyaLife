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
    @Published var userSession: FirebaseAuth.User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
            self?.isLoggedIn = userSession != nil
        }
        .store(in: &cancellables)
    }
}
