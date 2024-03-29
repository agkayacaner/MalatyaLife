//
//  MoreView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI
struct MoreView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var alertItem: AlertItem?
    @State var appVersion = Bundle.main.infoDictionary? ["CFBundleShortVersionString"] as? String ?? ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var appState: AppState
    
    private var currentUser: User? {
        return profileViewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            List {
                if appState.userSession != nil {
                    HStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.black)
                            .overlay(
                                Image(systemName: "person.crop.circle")
                                    .foregroundColor(.white)
                            )
                        
                        VStack(alignment:.leading,spacing: 5) {
                            currentUserFullname()
                            Text("\(currentUser?.email ?? "")")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(10)
                    }
                    
                    if profileViewModel.businessStatusControl() {
                        Section(header:Text("İşletmem")) {
                            NavigationLink("İşletmelerim", destination: UserBusinessesView())
                            NavigationLink("Etkinlik ve Duyurularım", destination: UserAnnouncementsView())
                            if profileViewModel.businesses.filter({ $0.isActive  }).count < 1 {
                                Button(action: {
                                    alertItem = AlertItem(title: Text("Etkinlik, Duyuru Talebi"), message: Text("Aktif bir işletmeniz yok!"), primaryButton: .default(Text("Tamam")), secondaryButton: nil)
                                }) {
                                    Text("Yeni Etkinlik, Duyuru Oluştur")
                                }
                                .foregroundStyle(.primary)
                            } else {
                                NavigationLink("Yeni Etkinlik, Duyuru Oluştur", destination: CreateAnnouncementView())
                            }
                        }
                        
                    }
                } else {
                    NavigationLink(destination: LoginView().toolbar(.hidden, for: .tabBar)) {
                        VStack(alignment:.leading,spacing: 5) {
                            Text("Giriş Yap / Kayıt Ol")
                                .font(.headline)
                            Text("Giriş yaparak tüm özellikleri kullanabilirsiniz.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        .padding(10)
                    }
                }
                
                Section {
                    NavigationLink("Nöbetçi Eczaneler", destination: PharmacyListView())
                    NavigationLink("Önemli Telefonlar", destination: EmergencyNumberListView())
                    NavigationLink("Son Depremler", destination: EarthquakeListView())
                }
                
                Section {
                    if appState.userSession != nil {
                        if !profileViewModel.businessStatusControl() {
                            Button(action: {
                                alertItem = AlertItem(title: Text("İşletme Talebi"), message: Text("Zaten bir işletme talebiniz bulunmakta."), primaryButton: .default(Text("Tamam")), secondaryButton: nil)
                            }) {
                                Text("Yeni İşletme Talebi")
                            }
                            .foregroundStyle(.primary)
                        } else {
                            NavigationLink("Yeni İşletme Talebi", destination: CreateBusinessView())
                        }
                    } else {
                        NavigationLink("Yeni İşletme Talebi", destination: LoginView().toolbar(.hidden, for: .tabBar))
                    }
                }.alert(item: $alertItem) { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.primaryButton)
                }
                
                Section {
                    NavigationLink("Hakkında", destination: AboutView(url: "https://www.malatyalife.lamamedya.com/about.php").navigationTitle("").navigationBarTitleDisplayMode(.inline))
                    
                    HStack {
                        Text("Uygulama Versiyonu")
                        Spacer()
                        Text(appVersion)
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Geliştirici")
                        Spacer()
                        Text("Caner Ağkaya")
                            .foregroundStyle(.secondary)
                    }
                }
                
                if appState.userSession != nil {
                    Button(action: {
                        AuthService.shared.signOut()
                        dismiss()
                    }, label: {
                        Text("Çıkış Yap")
                            .font(.headline)
                            .foregroundColor(.red)
                    })
                }
                
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .tabItem {
                Label("Home", systemImage: "house")
            }
        }
    }
    
    @ViewBuilder
    func currentUserFullname() -> some View {
        HStack(spacing:2) {
            Text("\(currentUser?.name ?? "")")
            Text("\(currentUser?.lastname ?? "")")
        }
        .font(.headline)
    }
}

#Preview {
    MoreView()
        .environmentObject(AppState())
}
