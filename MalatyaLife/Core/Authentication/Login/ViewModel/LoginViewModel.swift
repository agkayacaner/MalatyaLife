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
            let nsError = error as NSError
                   let errorMessage = nsError.userInfo[NSLocalizedDescriptionKey] as? String ?? "Bilinmeyen hata"
                   
                   if errorMessage == "E-posta adresi doğrulanmamış. Lütfen e-posta adresinizi doğrulayın." {
                       alertItem = AlertItem(
                           title: Text("Hata"),
                           message: Text(errorMessage),
                           primaryButton: .default(Text("Tamam")),
                           secondaryButton: .default(Text("E-postayı Yeniden Gönder"), action: {
                               Task {
                                   try await self.resendEmail()
                               }
                           } )
                       )
                   } else {
                       alertItem = AlertItem(
                           title: Text("Hata"),
                           message: Text(errorMessage),
                           primaryButton: .default(Text("Tamam")), secondaryButton: nil
                       )
                   }
                   
                   print(errorMessage)
        }
    }
    
    @MainActor
    func resendEmail() async throws {
        do {
            try await AuthService.shared.resendVerifyEmail()
            alertItem = AlertItem(
                title: Text("Başarılı"),
                message: Text("E-posta adresinize doğrulama e-postası gönderildi."),
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
