//
//  LoginView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import SwiftUI

struct RegisterView: View {
    @State var appIcon = UIImage(named: "AppIcon") ?? UIImage()
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    @State var lastname: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(alignment:.leading) {
                    Text("Kayıt Ol")
                        .font(.system(size: 54))
                        .fontWeight(.bold)
                        .padding(.bottom,20)
                    
                    TextField("Ad", text: $name)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                    TextField("Soyad", text: $lastname)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    
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
                    

                }

                Button(action: {
                    print("Kayıt Yapıldı")
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
        }
    }
}

#Preview {
    RegisterView()
}
