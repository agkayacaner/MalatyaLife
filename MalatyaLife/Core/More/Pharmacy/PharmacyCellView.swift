//
//  PharmacyCell.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct PharmacyCellView: View {
    var body: some View {
        HStack(alignment:.center, spacing:16) {
            Image(systemName: "asterisk.circle")
                .font(.largeTitle)
                .foregroundColor(.red)
        
            VStack(alignment:.leading){
        
                Text("Eczane Adı")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .padding(.bottom,2)
                

                Text("İlçe")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
            }
            
            Spacer()

        }
    }
}

#Preview {
    PharmacyCellView()
}
