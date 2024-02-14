//
//  FeaturedBusinessItem.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 23.01.2024.
//

import SwiftUI
import Kingfisher

struct FeaturedBusinessItem: View {
    @State var business : Business
    var width = UIScreen.main.bounds.width - 40
    
    var body: some View {
        VStack(alignment:.leading) {
            if #available(iOS 17.0, *) {
                if let imageUrl = business.images?.first {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width:width ,height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .containerRelativeFrame(.horizontal)
                } else {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundColor(Color(.secondarySystemBackground))
                        .frame(width:width ,height: 240)
                        .containerRelativeFrame(.horizontal)
                }
            } else {
                if let imageUrl = business.images?.first {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                } else {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundColor(Color(.secondarySystemBackground))
                        .frame(width: width, height: 240)
                }
            }
            VStack(alignment:.leading){
                Text(business.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text(business.category)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    FeaturedBusinessItem(business: BusinessMockData.sampleBusiness01)
}
