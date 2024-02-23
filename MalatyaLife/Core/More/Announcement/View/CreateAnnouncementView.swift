//
//  CreateAnnouncement.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 20.02.2024.
//

import SwiftUI

struct CreateAnnouncementView: View {
    @StateObject var viewModel = CreateViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Başlık *", text: $viewModel.form.name)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                    
                    TextField("Açıklama *", text: $viewModel.form.description, axis: .vertical)
                        .frame(minHeight: 54, alignment:.top)
                    
                    Picker("Kategori *",selection: $viewModel.form.category){
                        ForEach(Announcement.Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category.rawValue)
                        }
                    }
                    
                    Picker("İşletme *", selection: $viewModel.selectedBusinessID) {
                        ForEach(viewModel.businesses) { business in
                            Text(business.name).tag(business.id!)
                        }
                    }
                    
                } header: {
                    Text("Detaylar")
                        .textCase(.none)
                }
                
                Toggle("Tek Günlük", isOn: $viewModel.oneDay)
                
                Section {
                    DatePicker(
                        "Başlangıç",
                        selection: Binding(
                            get: { self.viewModel.form.startDate },
                            set: { newValue in
                                self.viewModel.form.startDate = newValue
                                print("Başlangıç tarihi güncellendi: \(newValue)")
                            }
                        ),
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    if !viewModel.oneDay {
                        DatePicker(
                            "Bitiş",
                            selection: Binding(
                                get: { self.viewModel.form.endDate },
                                set: { newValue in
                                    self.viewModel.form.endDate = newValue
                                    print("Başlangıç tarihi güncellendi: \(newValue)")
                                }
                            ),
                            displayedComponents: [.date, .hourAndMinute]
                        )
                    }
                } header: {
                    Text("Tarihler")
                        .textCase(.none)
                }
                
                
                Button {
                    if viewModel.isValidForm {
                        Task {
                            do {
                                try await viewModel.createNewAnnouncement()
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
            .navigationTitle("Yeni Duyuru / Etkinkil Talebi")
            .navigationBarTitleDisplayMode(.inline)
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.primaryButton)
            }
        }
    }
}

#Preview {
    CreateAnnouncementView()
}
