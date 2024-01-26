//
//  LoginView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(alignment:.leading) {
                    Text("Kayıt Ol")
                        .font(.system(size: 54))
                        .fontWeight(.bold)
                        .padding(.bottom,20)
                    
                    TextField("Ad", text: $viewModel.name)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    TextField("Soyad", text: $viewModel.lastname)
                        .autocorrectionDisabled()
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    TextField("Eposta", text: $viewModel.email)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    SecureField("Şifre", text: $viewModel.password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    
                }
                
                Button(action: {
                    Task {
                        try await viewModel.createUser()
                        dismiss()
                    }
                }) {
                    Text("Kayıt Ol")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.top)
                
                Spacer()
                
                Divider()
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing:3) {
                        Text("Hesabın var mı?")
                            .font(.footnote)
                        
                        Text("Giriş Yap")
                            .font(.footnote)
                            .fontWeight(.bold)
                    }
                }
                .padding(.vertical,16)
                
            }
            .padding(.horizontal)
            
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.primaryButton)
            }
        }
    }
}

#Preview {
    RegisterView()
}
