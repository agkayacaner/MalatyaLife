//
//  CreateBusinessView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI
import PhotosUI

struct CreateBusinessView: View {
    
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
                    
                    Picker("Kategori *",selection: $viewModel.form.category){
                        ForEach(Business.Category.allCases.filter { $0 != .all }, id: \.self) { category in
                            Text(category.rawValue).tag(category.rawValue)
                        }
                    }
                    
                    Picker("İlçe *",selection: $viewModel.form.district){
                        ForEach(Business.District.allCases.filter { $0 != .all}, id: \.self) { district in
                            Text(district.rawValue).tag(district.rawValue)
                        }
                    }
                } header: {
                    Text("İşletme Bilgileri")
                        .textCase(.none)
                }
                
                Section {
                    TextField("Telefon Numarası *", text: $viewModel.form.phone)
                        .keyboardType(.phonePad)
                    
                    TextField("E-Posta Adresi *", text: $viewModel.form.email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                } header: {
                    Text("İletişim Bilgileri")
                        .textCase(.none)
                } footer: {
                    Text("Telefon numarasını başında 0 (sıfır) olmadan yazınız")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                
                
                Section {
                    TextField("İşletme Hakkında *", text: $viewModel.form.description, axis: .vertical)
                        .autocorrectionDisabled()
                } header: {
                    Text("İşletme Hakkında")
                        .textCase(.none)
                } footer: {
                    Text("* İşletme detayında gösterilecek")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                
                Section{
                    viewModel.timePicker(selection: $viewModel.form.openingHour, label: "Açılış Saati *")
                    viewModel.timePicker(selection: $viewModel.form.closingHour, label: "Kapanış Saati *")
                    
                    Picker("Tatil Günü",selection: $viewModel.form.offDay){
                        ForEach(Business.WeekDay.allCases, id: \.self) { offDay in
                            Text(offDay.rawValue).tag(offDay.rawValue)
                        }
                    }
                } header: {
                    Text("İşletme Çalışma Saatleri")
                        .textCase(.none)
                }
                
                Section {
                    TextField("Facebook", text: $viewModel.form.facebook)
                    TextField("Instagram", text: $viewModel.form.instagram)
                    TextField("Twitter", text: $viewModel.form.twitter)
                } header: {
                    Text("İşletme Sosyal Medya Hesapları")
                        .textCase(.none)
                } footer: {
                    Text("Sadece Kullanıcı adlarını yazın!")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                
                if #available(iOS 17, *) {
                    Section {
                        if viewModel.selectedItems.count > 0 {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing:10) {
                                    ForEach(viewModel.selectedImages, id: \.self) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 220, height: 140)
                                            .clipShape(RoundedRectangle(cornerRadius: 4))
                                    }
                                }
                            }
                        }
                        PhotosPicker(selection:$viewModel.selectedItems, maxSelectionCount: 3 ,matching: .any(of: [.images, .not(.videos)])){
                            if viewModel.isLoadingImage {
                                VStack(spacing:5) {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .frame(maxWidth:.infinity)
                                        .padding(.vertical, 10)
                                        .background(.thinMaterial)
                                        .cornerRadius(8)
                                        .padding(.vertical, 10)
                                    
                                    Text("Yükleniyor...")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                            } else {
                                Label("İşletmenin Fotoğraflarını Ekle", systemImage: "photo")
                            }
                        }
                        .onChange(of: viewModel.selectedItems) { _, newValues in
                            Task {
                                viewModel.selectedImages = []
                                for value in newValues {
                                    if let imageData = try? await value.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                                        viewModel.selectedImages.append(image)
                                    }
                                }
                            }
                        }
                    } footer: {
                        Text("En fazla 3 adet görsel seçebilirsiniz")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Button {
                    if viewModel.isValidForm {
                        Task {
                            do {
                                try await viewModel.uploadBusiness()
                                dismiss()
                            } catch {
                                
                            }
                        }
                    }
                } label: {
                    Text("Kaydet")
                        .fontWeight(.semibold)
                        .frame(maxWidth:.infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .navigationTitle("Yeni İşletme Talebi")
            .navigationBarTitleDisplayMode(.inline)
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.primaryButton)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateBusinessView()
    }
}
