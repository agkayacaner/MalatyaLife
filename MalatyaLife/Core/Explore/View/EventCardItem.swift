//
//  EventCardItem.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 23.01.2024.
//

import SwiftUI

struct EventCardItem: View {
    var width = UIScreen.main.bounds.width - 40
    
    var body: some View {
        VStack(alignment:.leading) {
            
            ZStack(alignment:.bottomLeading) {
                if #available(iOS 17.0, *) {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundColor(Color(.secondarySystemBackground))
                        .frame(height: 200)
                        .containerRelativeFrame(.horizontal)
                } else {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundColor(Color(.secondarySystemBackground))
                        .frame(width: width,height: 200)
                }
                
                Text("10 Aralık")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.accent)
                    .clipShape(UnevenRoundedRectangle(cornerRadii:.init(
                        topLeading: 0,
                        bottomLeading: 14,
                        bottomTrailing: 0,
                        topTrailing: 34
                    )))
            }
            
            VStack(alignment:.leading){
                Text("Etkinlik Adı")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text("Alt Başlık")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    EventCardItem()
}
