//
//  RegisterViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import SwiftUI

final class RegisterViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var lastname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var alertItem: AlertItem?
    
    @Published var isCreationSuccess = false
    
    @MainActor
    func createUser() async throws {
        do {
            try await AuthService.shared.createUser(withEmail: email, name: name, lastname: lastname, password: password)
            alertItem = AlertItem(title: Text("Success"), message: Text("User created!"), primaryButton: .default(Text("OK")),secondaryButton: nil)
            isCreationSuccess = true
        } catch {
            alertItem = AlertItem(title: Text("Error"), message: Text("\(error.localizedDescription)"), primaryButton: .default(Text("OK")),secondaryButton: nil)
            print(error.localizedDescription)
        }
    }
}
