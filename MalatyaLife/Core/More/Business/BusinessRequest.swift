//
//  BusinessRequest.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct BusinessRequest: View {
    var body: some View {
        NavigationStack {
            
            Form {
                Section("İşletme Bilgileri") {
                    TextField("İşletmenin Adı", text: .constant(""))
                    TextField("Başvuran / İşetme Sahibi", text: .constant(""))
                    TextField("Açık Adres", text: .constant(""), axis: .vertical)
                    // Category Picker
                    // State Picker
                }
                
                Section("İletişim Bilgileri") {
                    TextField("Telefon Numarası", text: .constant(""))
                    TextField("E-Posta Adresi", text: .constant(""))
                }
                
                Section("İşletme Hakkında") {
                    TextField("İşletme Hakkında", text: .constant(""), axis: .vertical)
                    Text("* İşletme detayında gösterilecek")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                
                Section("İşletme Çalışma Saatleri") {
                    TextField("Örneğin 08.00 - 22:00", text: .constant(""), axis: .vertical)
                    // Off Day Picker
                }
                
                Section("İşletme Sosyal Medya Hesapları") {
                    TextField("Facebook", text: .constant(""))
                    TextField("Instagram", text: .constant(""))
                    TextField("Twitter", text: .constant(""))
                }
                
                Section("İşletme Fotoğrafları") {
                    Text("Fotoğraf Ekle")
                }
            }
            
            .navigationTitle("Yeni İşletme Talebi")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    print("Save")
                }, label: {
                    Text("Kaydet")
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        BusinessRequest()
    }
}
