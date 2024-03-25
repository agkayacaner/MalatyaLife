//
//  PharmacyDetailView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct PharmacyDetailView: View {
    @State var pharmacy: Pharmacy
    
    var body: some View {
        VStack(alignment:.leading) {
            VStack(alignment:.leading) {

                Text(pharmacy.name.capitalized)
                        .font(.title2).bold().foregroundStyle(.red)
                        .padding(.bottom, 10)

                
                HStack {

                    Text(pharmacy.district?.capitalized ?? "")
                            .font(.subheadline).bold().foregroundStyle(.secondary)
                    
   
                    Spacer()
                }
            }
            Divider()
                .padding(.vertical, 10)
            VStack( alignment:.leading) {
                Text(pharmacy.description)
                    .font(.subheadline).foregroundStyle(.red)
                    .padding(.bottom, 10)
            
                Text("Adres")
                Text(pharmacy.address)
                    .font(.subheadline).foregroundStyle(.secondary)
                    .padding(.vertical)
                
                Spacer()
                
                Button {
                    print("Call")
                } label: {
                    HStack{
                        Image(systemName: "phone")
                        Link(destination: URL(string: "tel:\(pharmacy.phone)")!, label: {
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
    PharmacyDetailView(pharmacy: PharmacyMockData.samplePharmacy01)
}
