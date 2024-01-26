//
//  ResetPasswordView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject var viewModel = ResetPasswordViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment:.leading) {
                Text("Şifremi Sıfırla")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom,20)
                
                TextField("Sisteme kayıtlı Eposta adresinizi giriniz", text: $viewModel.email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.bottom)
            }

            Button(action: {
                Task {
                    try await viewModel.resetPassword()
                    dismiss()
                }
            }) {
                Text("Şifremi Sıfırla")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .alert(item: $viewModel.alertItem) { alertItem in
            if let secondaryButton = alertItem.secondaryButton {
                return Alert(
                    title: alertItem.title,
                    message: alertItem.message,
                    primaryButton: alertItem.primaryButton,
                    secondaryButton: secondaryButton
                )
            } else {
                return Alert(
                    title: alertItem.title,
                    message: alertItem.message,
                    dismissButton: alertItem.primaryButton
                )
            }
        }
    }
}

#Preview {
    ResetPasswordView()
}
