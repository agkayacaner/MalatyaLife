//
//  ResetPasswordViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 25.01.2024.
//

import SwiftUI

final class ResetPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var alertItem: AlertItem?
    
    @MainActor
    func resetPassword() async throws {
        do {
            try await AuthService.shared.resetPassword(withEmail: email)
            alertItem = AlertItem(
                title: Text("Başarılı"),
                message: Text("Şifre sıfırlama e-postası adresinize gönderildi."),
                primaryButton: .default(Text("Tamam")), secondaryButton: nil
            )
            
        } catch {
            let nsError = error as NSError
            let errorMessage = nsError.userInfo[NSLocalizedDescriptionKey] as? String ?? "Bilinmeyen hata"
            
            alertItem = AlertItem(
                title: Text("Hata"),
                message: Text(errorMessage),
                primaryButton: .default(Text("Tamam")), secondaryButton: nil
            )
            
            print(errorMessage)
        }
    }
}
