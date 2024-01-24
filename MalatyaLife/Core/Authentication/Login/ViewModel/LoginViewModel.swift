//
//  LoginViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @ObservedObject private var appState = AppState()
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLogged: Bool = false
    
    @Published var alertItem: AlertItem?
    
    @MainActor
    func login() async throws {
        do {
            try await AuthService.shared.login(withEmail: email, password: password)
            isLogged = true
            
            if !appState.isOnboardingDone {
                appState.isOnboardingDone = true
            }
            
        } catch {
            alertItem = AlertItem(title: Text("Error"), message: Text("\(error.localizedDescription)"), dismissButton: .default(Text("OK")))
            print(error.localizedDescription)
        }
    }
    
}
