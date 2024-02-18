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
    var event: Event
    
    var body: some View {
        VStack(alignment:.leading) {
            VStack {
                if let imageUrl = event.image {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160,height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
            .overlay {
                VStack {
                    Spacer()
                    
                    HStack {
                        Text(viewModel.getEventDate(dateString: event.date))
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
                        
                        Spacer()
                    }
                }
            }
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            
            VStack(alignment:.leading, spacing: 0) {
                Text(event.name)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .font(.subheadline)
                    .padding(.horizontal, 4)
            }
            .frame(width: 160)
        }
        
    }
}


#Preview {
    EventCardItem(event: EventMockData.events[0])
}
