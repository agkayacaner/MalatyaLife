//
//  BusinessDetailView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI
import Kingfisher

struct BusinessDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var business : Business
    @StateObject var viewModel = BusinessViewModel()
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment:.leading, spacing: 0) {
                BusinessImages()
                    .overlay {
                        HeaderActions()
                    }
                
                HStack {
                    VStack(alignment:.leading) {
                        Text(business.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Text("\(business.district)\(viewModel.districtSuffix(district: business.district)) bir \(business.category)")
                        
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.bottom)
                
                Divider()
                
                VStack(alignment:.leading, spacing:10) {
                    HStack(alignment:.center) {
                        VStack(alignment:.leading,spacing: 10){
                            HStack {
                                Text(business.workingHours)
                                    .foregroundStyle(.primary)
                                    .bold()
                                Text("arası açık")
                            }
                            
                            if viewModel.showWeekendWH(business: business) != "" {
                                Text(viewModel.showWeekendWH(business: business))
                                    .font(.subheadline)
                            }
                        }
                        
                        Spacer()
                        
                        Text(viewModel.getOffDay(business: business))
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    
                    Text(business.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.top)
                    
                    Text("Adres")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.top)
                    
                    Text(business.address)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    BusinessSocialLinks()
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
                    .padding(.top,30)
                    .padding(.bottom,20)
                }
                .padding()
            }
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    @ViewBuilder
    func BusinessImages() -> some View {
        if let imageUrls = business.images {
            TabView() {
                ForEach(imageUrls, id: \.self) { imageUrl in
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: screenWidth, height: 320)
                        .clipped()
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .frame(height: 320)
        }
    }
    
    @ViewBuilder
    func BusinessSocialLinks() -> some View {
        HStack {
            HStack(spacing:20) {
                if (business.website != "") {
                    Button {
                        guard let url = URL(string: "\(business.website!)") else { return }
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
        }
        .padding(.top,20)
    }
    
    @ViewBuilder
    func HeaderActions() -> some View {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let edgeInsets = scene?.windows.first?.safeAreaInsets ?? .zero
        VStack {
            HStack {
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .padding()
                }
                .foregroundColor(.primary)
                .background(.regularMaterial)
                .clipShape(Circle())
            }
            .padding(.horizontal,20)
            
            Spacer()
        }
        .padding(.top, edgeInsets.top)
    }
}

#Preview {
    BusinessDetailView(business: BusinessMockData.sampleBusiness01)
}



