//
//  LoginView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(alignment:.leading) {
                    Text("Giriş Yap")
                        .font(.system(size: 54))
                        .fontWeight(.bold)
                        .padding(.bottom,20)
                    
                    TextField("Eposta", text: $viewModel.email)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    SecureField("Şifre", text: $viewModel.password)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    NavigationLink(destination: ResetPasswordView()) {
                        Text("Şifremi unuttum")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.vertical)
                            .padding(.trailing)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }

                Button(action: {
                    Task { try await viewModel.login() }
                    
                }) {
                    Text("Giriş Yap")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                
                Spacer()
                
                Divider()
                
                NavigationLink(destination: RegisterView().navigationBarBackButtonHidden()) {
                    HStack(spacing:3) {
                        Text("Hesabın yok mu?")
                            .font(.footnote)
                        
                        Text("Kayıt Ol")
                            .font(.footnote)
                            .fontWeight(.bold)
                    }
                }
                .padding(.vertical,16)
            }
            .padding(.horizontal)
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
    
}

#Preview {
    LoginView()
}
