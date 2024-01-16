//
//  MoreView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct MoreView: View {
    @State var appVersion = Bundle.main.infoDictionary? ["CFBundleShortVersionString"] as? String ?? ""
    @State var isLogin = false
    
    var body: some View {
        NavigationStack {
            List {
                // TODO: - Login version
                
                Section {
                    NavigationLink("Nöbetçi Eczaneler", destination: PharmacyListView())
                    NavigationLink("Önemli Telefonlar", destination: EmergencyNumberListView())
                    NavigationLink("Son Depremler", destination: EarthquakeListView())
                }
                
                Section {
                    NavigationLink("Yeni İşletme Talebi", destination: BusinessRequestView())
                }
                Section {
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
            }
            .navigationTitle("Daha Fazla")
        }
    }
}

#Preview {
    MoreView()
}
