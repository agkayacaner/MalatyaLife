//
//  NewsCellView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 30.01.2024.
//

import SwiftUI

struct NewsCellView: View {
    var body: some View {
        VStack(alignment:.leading){
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(.accent)
                .frame(height: 200)
            
            VStack(alignment:.leading, spacing: 4) {
                Text("Haber Başlığı")
                    .font(.body)
                    .fontWeight(.bold)
                
                Text("2 dakika")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(10)
        }
    }
}

#Preview {
    NewsCellView()
        .padding()
}
