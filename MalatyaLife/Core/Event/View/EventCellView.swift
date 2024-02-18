//
//  EventCellView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 14.02.2024.
//

import SwiftUI
import Kingfisher

struct EventCellView: View {
    @StateObject var viewModel = EventViewModel()
    @State var event: Event
    
    var body: some View {
        HStack {
            if let imageURL = event.image {
                
                KFImage(URL(string: imageURL))
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .frame(width: 120, height: 160)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(event.name)
                    .font(.title3).bold()
                
                VStack(alignment: .leading, spacing:8) {
                    Text(viewModel.getEventDate(dateString: event.date))

                    Text(event.time)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        
    }
}

#Preview {
    EventCellView(event: EventMockData.events.first!)
}
