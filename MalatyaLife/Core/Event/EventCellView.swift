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
                GeometryReader { geo in
                    KFImage(URL(string: imageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .offset(y: -(geo.size.height - 100) / 2)
                }
                .frame(width: 140, height: 84)
            }
            
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline)
            }
            
            Spacer()
        }
        
    }
}

#Preview {
    EventCellView(event: EventMockData.events.first!)
}
