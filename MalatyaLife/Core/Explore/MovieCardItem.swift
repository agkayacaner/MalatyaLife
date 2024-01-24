//
//  MovieCardItem.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 23.01.2024.
//

import SwiftUI

struct MovieCardItem: View {
    var body: some View {
        VStack(alignment:.leading) {
            RoundedRectangle(cornerRadius: 14)
                .foregroundColor(.accentColor)
                .frame(width: 200 ,height: 260)
            
            VStack(alignment:.leading){
                Text("Film Adı")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MovieCardItem()
}
