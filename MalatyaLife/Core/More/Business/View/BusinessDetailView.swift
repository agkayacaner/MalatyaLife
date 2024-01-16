//
//  BusinessDetailView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI
import Kingfisher

struct BusinessDetailView: View {
    @State var business : Business
    @Environment(\.dismiss) var dismiss
    
    var screenWidth = UIScreen.main.bounds.width
 
    var body: some View {
        ZStack {
            VStack(alignment:.leading) {
                VStack {
                    if let imageUrl = business.image {
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: screenWidth, height: 360)
                            .clipShape(UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 64, bottomTrailing: 64)))
                    } else {
                        Image(systemName: "camera")
                            .resizable()
                            .frame(width: 44,height: 44)
                            .clipShape(UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 64, bottomTrailing: 64)))
                    }
                }
                .ignoresSafeArea()
                
                VStack(alignment:.leading) {
                    Text(business.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Text(business.category)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                .padding(.top,-50)
                
                Divider()
                    .padding(20)
                
                VStack(alignment:.leading) {
                    Text(business.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        HStack(spacing:20) {
                            if (business.website != "") {
                                Button {
                                    guard let url = URL(string: "\(business.facebook!)") else { return }
                                    UIApplication.shared.open(url)
                                } label: {
                                    Image(systemName: "globe")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                            }
                            
                            
                            if (business.facebook != "") {
                                Button {
                                    guard let url = URL(string: "https://facebook.com/\(business.facebook!)") else { return }
                                    UIApplication.shared.open(url)
                                } label: {
                                    Image("facebook-icon")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                            }
                            
                            if (business.instagram != "") {
                                Button {
                                    guard let url = URL(string: "https://instagram.com/\(business.instagram!)") else { return }
                                    UIApplication.shared.open(url)
                                } label: {
                                    Image("instagram-icon")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                            }
                            
                        }
                        
                        Spacer()
                        
//                        Button {
//                            
//                        } label: {
//                            Image(systemName: "map")
//                                .resizable()
//                                .frame(width: 24, height: 24)
//                            
//                            Text("Göster")
//                                .font(.subheadline)
//                        }
//                        .foregroundStyle(Color.brown)
//                        
                    }
                    .padding(.top,20)
                    
                    Spacer()
                    
                    Button {
                        guard let url = URL(string: "tel://\(business.phone)") else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        Text("Ara")
                            .font(.body)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .tint(.green)
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .padding(.bottom,20)
                }
                .padding(.horizontal,20)
            }
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.title)
                            .padding()
                    }
                    .foregroundColor(.white)
                    .background(.accent)
                    .clipShape(Circle())
                    
                    Spacer()
                }
                .padding(.horizontal,20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    BusinessDetailView(business: BusinessMockData.sampleBusiness01)
}
