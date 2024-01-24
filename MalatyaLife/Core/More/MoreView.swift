//
//  MoreView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct MoreView: View {
    @State var appVersion = Bundle.main.infoDictionary? ["CFBundleShortVersionString"] as? String ?? ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var appState: AppState
    
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
                            Text("Caner Ağkaya")
                                .font(.headline)
                            Text("\("agkayacaner@gmail.com")")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(10)
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
                    NavigationLink("Yeni İşletme Talebi", destination: BusinessRequestView())
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
}

#Preview {
    MoreView()
        .environmentObject(AppState())
}
