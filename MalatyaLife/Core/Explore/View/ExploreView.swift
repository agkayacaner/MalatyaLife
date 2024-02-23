//
//  ExploreView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var viewModel = ExploreViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(){
                    header()
                    VStack(spacing:20) {
                        featuredItems()
                        
                        categories()
                        
                        latestFiveItem()
                        
                        latestFiveEvent()
                        
                        announcement()
                    }
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    func header() -> some View{
        HStack {
            VStack(alignment:.leading,spacing: 4){
                Text("Merhaba")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Bugün \(Date.getCurrentDate())")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            
            NavigationLink(destination: NotificationView()) {
                ZStack{
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.primary)
                    
                    Circle()
                        .fill(Color.accent)
                        .frame(width: 10, height: 10)
                        .offset(x: 10, y: -10)
                }
            }
            
        }
        .padding()
    }
    
    @ViewBuilder
    func featuredItems() -> some View{
        Section {
            if #available(iOS 17.0, *) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:0) {
                        ForEach(viewModel.featuredBusinesses) { business in
                            NavigationLink(destination: BusinessDetailView(business: business).navigationBarBackButtonHidden()) {
                                FeaturedBusinessItem(business: business)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .contentMargins(20, for: .scrollContent)
                .listRowInsets(EdgeInsets())
                .padding(.bottom, -30)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            else{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:10) {
                        ForEach(viewModel.featuredBusinesses) { business in
                            NavigationLink(destination: BusinessDetailView(business: business).navigationBarBackButtonHidden()) {
                                FeaturedBusinessItem(business: business)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .listRowInsets(EdgeInsets())
            }
        }
    }
    
    @ViewBuilder
    func categories() -> some View{
        Section {
            if #available(iOS 17.0, *) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        ForEach( viewModel.categories ) { category in
                            NavigationLink(destination: CategoryView(searchTerms: category.name, categoryName:category.name)) {
                                CategoryCell(category: category)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .contentMargins(20, for: .scrollContent)
                .listRowInsets(EdgeInsets())
            }
            else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:10) {
                        ForEach(viewModel.categories) { category in
                            NavigationLink(destination: CategoryView(searchTerms: category.name, categoryName:category.name)) {
                                CategoryCell(category: category)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .listRowInsets(EdgeInsets())
            }
        }
    }
    
    @ViewBuilder
    func latestFiveItem() -> some View{
        Section {
            VStack(alignment:.leading) {
                VStack(alignment:.leading){
                    Text("YENİ EKLENENLER")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                    Text("Buraları keşfet")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(viewModel.latestBusinesses.prefix(5)) { business in
                    NavigationLink(destination: BusinessDetailView(business: business).navigationBarBackButtonHidden()) {
                        BusinessCell(business: business)
                    }
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func landmarks() -> some View {
        let gridItems: [GridItem] = [
            .init(),
        ]
        
        Section {
            VStack(alignment:.leading) {
                VStack(alignment:.leading){
                    HStack(){
                        Text("GEZİLECEK YERLER")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                        Spacer()
                        
                        NavigationLink(destination: Text("Landmarks")) {
                            HStack {
                                Text("Tümünü Gör")
                                    .fontWeight(.semibold)
                                Image(systemName: "chevron.right")
                            }
                            .font(.caption)
                        }
                    }
                    Text("Destan Şehri Malatya")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: gridItems, spacing: 10) {
                        ForEach(0..<4) { index in
                            RoundedRectangle(cornerRadius: 14)
                                .frame(width: 140, height: 84)
                                .foregroundStyle(Color(.systemBackground))
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 10)
            }
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func latestFiveEvent() -> some View{
        Section {
            if #available(iOS 17.0, *) {
                VStack(alignment:.leading) {
                    VStack(alignment:.leading){
                        Text("YAKLAŞAN ETKİNLİKLER")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal,20)
                    .padding(.bottom,-20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.events) { event in
                                NavigationLink(destination: EventDetailView(event: event).toolbar(.hidden, for: .tabBar)) {
                                    EventCardItem(event: event)
                                }
                                .foregroundStyle(.primary)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(20, for: .scrollContent)
                    .listRowInsets(EdgeInsets())
                }
                
            } else {
                VStack(alignment:.leading) {
                    VStack(alignment:.leading){
                        Text("YAKLAŞAN ETKİNLİKLER")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal,20)
                    .padding(.bottom,-20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing:10) {
                            ForEach(viewModel.events) { event in
                                NavigationLink(destination: EventDetailView(event: event).toolbar(.hidden, for: .tabBar)) {
                                    EventCardItem(event: event)
                                }
                                .foregroundStyle(.primary)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
        }
    }
    
    @ViewBuilder
    func announcement() -> some View {
        Section {
            VStack(alignment:.leading) {
                HStack {
                    VStack(alignment:.leading){
                        Text("İşletmelerden")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("DUYURU VE ETKİNLİKLER")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: AnnouncementView()) {
                        Text("Tümünü Gör")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.accent)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                
                ForEach(viewModel.announcements.prefix(5)) { announcement in
                    NavigationLink(destination: AnnouncementDetailsView(announcement: announcement)) {
                        AnnouncementCell(announcement: announcement)
                    }
                    .foregroundStyle(.primary)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ExploreView()
}
