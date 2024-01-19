//
//  ResetPasswordView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import SwiftUI

struct ResetPasswordView: View {
    @State var email: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment:.leading) {
                Text("Şifremi Sıfırla")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom,20)
                
                TextField("Eposta", text: $email)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
                
                    Text("Sisteme kayıtlı Eposta adresinizi giriniz.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.vertical)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
            }

            Button(action: {
                print("Giriş Yapıldı")
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
    }
}

#Preview {
    ResetPasswordView()
}
