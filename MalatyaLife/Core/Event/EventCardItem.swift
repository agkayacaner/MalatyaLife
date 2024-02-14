//
//  EventCardItem.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 23.01.2024.
//

import SwiftUI
import Kingfisher

struct EventCardItem: View {
    @StateObject var viewModel = EventViewModel()
    
    var width = UIScreen.main.bounds.width - 40
    var event: Event
    
    var body: some View {
        VStack(alignment:.leading) {
            
            ZStack(alignment:.bottomLeading) {
                if #available(iOS 17.0, *) {
                    if let imageUrl = event.image {
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width,height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .containerRelativeFrame(.horizontal)
                    }
                } else {
                    if let imageUrl = event.image {
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width,height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
                
                Text(viewModel.getEventDate(event: event))
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
                Text(event.name)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    EventCardItem(event: EventMockData.events[0])
        .padding()
}
