//
//  BusinessRequest.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI
import PhotosUI

struct BusinessRequestView: View {
    
    @StateObject var viewModel = BusinessRequestViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("İşletme Bilgileri") {
                    TextField("İşletmenin Adı *", text: $viewModel.name)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                        
                    TextField("Başvuran / İşetme Sahibi *", text: $viewModel.owner)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                    
                    TextField("Açık Adres *", text: $viewModel.address, axis: .vertical)
                        .autocorrectionDisabled()
                    
                    TextField("Web Sitesi", text: $viewModel.website, axis: .vertical)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.URL)
                    // Category Picker
                    Picker("Kategori",selection: $viewModel.category){
                        ForEach(Business.Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category.rawValue)
                        }
                    }
                    // State Picker
                    Picker("İlçe",selection: $viewModel.state){
                        ForEach(Business.State.allCases, id: \.self) { state in
                            Text(state.rawValue).tag(state.rawValue)
                        }
                    }
                }
                
                Section("İletişim Bilgileri") {
                    TextField("Telefon Numarası *", text: $viewModel.phone)
                        .keyboardType(.phonePad)
                    TextField("E-Posta Adresi *", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                }
                
                Section("İşletme Hakkında") {
                    TextField("İşletme Hakkında *", text: $viewModel.description, axis: .vertical)
                        .autocorrectionDisabled()
                    Text("* İşletme detayında gösterilecek")
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
                
                Section("İşletme Çalışma Saatleri") {
                    TextField("Örneğin 08.00 - 22:00 *", text: $viewModel.workingHours, axis: .vertical)
                        .autocorrectionDisabled()
                        .keyboardType(.numbersAndPunctuation)
                    // Off Day Picker
                    Picker("Tatil Günü",selection: $viewModel.offDay){
                        ForEach(Business.WeekDay.allCases, id: \.self) { offDay in
                            Text(offDay.rawValue).tag(offDay.rawValue)
                        }
                    }
                }
                
                Section("İşletme Sosyal Medya Hesapları") {
                    TextField("Facebook", text: $viewModel.facebook)
                    TextField("Instagram", text: $viewModel.instagram)
                    TextField("Twitter", text: $viewModel.twitter)
                    Text("* Sadece Kullanıcı adlarını yazın!")
                        .font(.footnote)
                        .foregroundStyle(.red)
                     
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                Section("Görsel Seçiniz") {
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
                }
                
            }
            
            .navigationTitle("Yeni İşletme Talebi")
            .navigationBarTitleDisplayMode(.inline)
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Kaydet") {
                    Task {
                        try await viewModel.saveForm()
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
