//
//  EventDetailView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 14.02.2024.
//

import SwiftUI
import Kingfisher

struct EventDetailView: View {
    @State var event: Event
    @StateObject var viewModel = EventViewModel()
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView {
            VStack(alignment:.leading) {
                if let imageURL = event.image {
                    KFImage(URL(string: imageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: screenWidth, height: 220)
                        .clipped()
                }
                VStack(alignment:.leading, spacing:10) {
                    Text(event.name)
                        .font(.title).bold()
                    
                    Text(viewModel.getEventDate(event: event))
                    
                    Text(event.description)
                        .font(.body)
                }
                .padding()
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EventDetailView(event: EventMockData.events[0])
}
