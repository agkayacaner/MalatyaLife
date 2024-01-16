//
//  PharmacyDetailView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct PharmacyDetailView: View {
    var body: some View {
        VStack(alignment:.leading) {
            VStack(alignment:.leading) {

                Text("Eczane Adı")
                        .font(.title2).bold().foregroundStyle(.red)
                        .padding(.bottom, 10)

                
                HStack {

                    Text("İlçe")
                            .font(.subheadline).bold().foregroundStyle(.secondary)
                    
   
                    Spacer()
                }
            }
            Divider()
                .padding(.vertical, 10)
            VStack( alignment:.leading) {
                Text("Açıklama")
                    .font(.subheadline).foregroundStyle(.red)
                    .padding(.bottom, 10)
            
                Text("Adres")
                Text("Adres Buraya Gelecek")
                    .font(.subheadline).foregroundStyle(.secondary)
                    .padding(.bottom, 30)
                
                Spacer()
                
                Button {
                    print("Call")
                } label: {
                    HStack{
                        Image(systemName: "phone")
                        Link(destination: URL(string: "tel:\("1111")")!, label: {
                            Text("Eczaneyi Ara")
                        })
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .tint(.red)
                
            }
        }
        .padding()
    }
}

#Preview {
    PharmacyDetailView()
}
