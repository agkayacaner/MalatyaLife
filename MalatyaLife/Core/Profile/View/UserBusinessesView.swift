//
//  UserBusinessesView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 25.01.2024.
//

import SwiftUI

struct UserBusinessesView: View {
    var body: some View {
        List {
            Section {
                VStack(alignment:.leading) {
                    Text("User Name")
                    Text("email@mail.com")
                }
            }
            
            Section {
                Text("İşletmelerim")
                Text("Yeni Etkinlik, Duyuru Oluştur")
            }
        }
    }
}

#Preview {
    UserBusinessesView()
}
