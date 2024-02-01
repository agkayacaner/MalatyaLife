//
//  BusinessCellView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI
import Kingfisher

struct BusinessCellView: View {
    @State var business: Business
    
    var body: some View {
        HStack{
            if let imageUrl = business.images?.first {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 94,height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 44,height: 44)
                    .foregroundStyle(Color(.systemGray4))
            }
            
            VStack(alignment:.leading) {
                Text(business.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(business.category)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    BusinessCellView(business: BusinessMockData.sampleBusiness01)
}
