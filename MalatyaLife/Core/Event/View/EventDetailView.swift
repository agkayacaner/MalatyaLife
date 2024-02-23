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
                        .clipped()
                }
                
                VStack(alignment:.leading, spacing:15) {
                    VStack(alignment:.leading, spacing: 10) {
                        Text(event.name)
                            .font(.title).bold()
                        
                        VStack(alignment:.leading, spacing:10) {
                            
                            HStack {
                                Text("\(viewModel.getEventDate(dateString: event.date))")
                                Text("saat: \(event.time)")
                            }
                            
                            Text(event.location)
                        }
                        .foregroundStyle(.secondary)
                    }
                    
                    Divider()
                    
                    Text(event.description)
                        .font(.body)
                        .lineSpacing(8)
                    
                    Button(action: {
                        guard let url = URL(string: "https://biletinial.com/tr-tr/sehrineozel/malatya") else { return }
                        UIApplication.shared.open(url)
                        
                    }) {
                        Text("Daha Fazla Bilgi ve Bilet İçin")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                    .font(.subheadline)
                }
                .padding()
            }
            Spacer()
        }
        .ignoresSafeArea(edges:.top)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EventDetailView(event: EventMockData.events[0])
}
