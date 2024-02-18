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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment:.leading) {
                
                if let imageURL = event.image {
                    KFImage(URL(string: imageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 220, height: 320)
                        .clipped()
                }
                
                VStack(alignment:.leading, spacing:10) {
                    Text(event.name)
                        .font(.title).bold()
                    
                    VStack(alignment:.leading, spacing:5) {
                        
                        HStack {
                            Text("\(viewModel.getEventDate(dateString: event.date))")
                            Text("saat: \(event.time)")
                        }
                        
                        
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundStyle(.secondary)
                            
                            Text(event.location)
                        }
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    
                    
                    
                    Divider()
                    
                    Text(event.description)
                        .font(.body)
                        .lineSpacing(8)
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
