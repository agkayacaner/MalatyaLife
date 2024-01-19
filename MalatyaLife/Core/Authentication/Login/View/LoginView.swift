//
//  LoginView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(alignment:.leading) {
                    Text("Giriş Yap")
                        .font(.system(size: 54))
                        .fontWeight(.bold)
                        .padding(.bottom,20)
                    
                    TextField("Eposta", text: $email)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    SecureField("Şifre", text: $password)
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
                    print("Giriş Yapıldı")
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
    }
}

#Preview {
    LoginView()
}
