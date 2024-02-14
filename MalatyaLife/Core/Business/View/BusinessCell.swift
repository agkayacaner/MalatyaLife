//
//  LatestBusinesses.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 23.01.2024.
//

import SwiftUI
import Kingfisher

struct BusinessCell: View {
    @State var business: Business
    
    var body: some View {
        HStack(spacing:10) {
            
            if let imageUrl = business.images?.first {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            } else {
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: 64, height: 64)
                    .foregroundColor(.red)
            }
            
            VStack(alignment:.leading,spacing: 4) {
                Text(business.name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(business.category)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

#Preview {
    BusinessCell(business: BusinessMockData.sampleBusiness01)
        .padding()
}
