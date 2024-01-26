//
//  BusinessRequest.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI
import PhotosUI

struct BusinessRequestView: View {
    
    @StateObject var viewModel = BusinessViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    CustomTextField(title: "İşletmenin Adı *", text: $viewModel.form.name)
                        
                    CustomTextField(title: "İşletmenin Sahibi *", text: $viewModel.form.owner)
                    
                    TextField("Açık Adres *", text: $viewModel.form.address, axis: .vertical)
                        .autocorrectionDisabled()
                    
                    TextField("Web Sitesi", text: $viewModel.form.website, axis: .vertical)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.URL)
                    
                    Picker("Kategori",selection: $viewModel.form.category){
                        ForEach(Business.Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category.rawValue)
                        }
                    }
                    
                    Picker("İlçe",selection: $viewModel.form.district){
                        ForEach(Business.District.allCases, id: \.self) { district in
                            Text(district.rawValue).tag(district.rawValue)
                        }
                    }
                } header: {
                    Text("İşletme Bilgileri")
                }
                
                
                Section {
                    TextField("Telefon Numarası *", text: $viewModel.form.phone)
                        .keyboardType(.phonePad)
                    
                    TextField("E-Posta Adresi *", text: $viewModel.form.email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                } header: {
                    Text("İletişim Bilgileri")
                }
                
                Section {
                    TextField("İşletme Hakkında *", text: $viewModel.form.description, axis: .vertical)
                        .autocorrectionDisabled()
                } header: {
                    Text("İşletme Hakkında")
                } footer: {
                    Text("* İşletme detayında gösterilecek")
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
                
                Section{
                    TextField("Örneğin 08.00 - 22:00 *", text: $viewModel.form.workingHours, axis: .vertical)
                        .autocorrectionDisabled()
                        .keyboardType(.numbersAndPunctuation)
                    
                    Picker("Tatil Günü",selection: $viewModel.form.offDay){
                        ForEach(Business.WeekDay.allCases, id: \.self) { offDay in
                            Text(offDay.rawValue).tag(offDay.rawValue)
                        }
                    }
                } header: {
                    Text("İşletme Çalışma Saatleri")
                }
                
                Section {
                    TextField("Facebook", text: $viewModel.form.facebook)
                    TextField("Instagram", text: $viewModel.form.instagram)
                    TextField("Twitter", text: $viewModel.form.twitter)
                } header: {
                    Text("İşletme Sosyal Medya Hesapları")
                } footer: {
                    Text("Sadece Kullanıcı adlarını yazın!")
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                Section {
                    PhotosPicker(selection: $viewModel.selectedImage) {
                        if let image = viewModel.image {
                            ZStack {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 220)
                                
                                if $viewModel.isLoadingImage.wrappedValue {
                                    LoadingView()
                                }
                            }
                        } else {
                            HStack {
                                Spacer()
                                Image(systemName: "camera")
                                    .font(.largeTitle)
                                Spacer()
                            }
                            .frame(height: 220)
                        }
                    }
                } header: {
                    Text("İşletme Fotoğrafı")
                }
                
            }
            
            .navigationTitle("Yeni İşletme Talebi")
            .navigationBarTitleDisplayMode(.inline)
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.primaryButton)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Kaydet") {
                    Task {
                        try await viewModel.uploadBusiness()
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BusinessRequestView()
    }
}
