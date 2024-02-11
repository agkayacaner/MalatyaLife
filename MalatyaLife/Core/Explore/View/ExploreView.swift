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
                    // Header
                    header()
                    
                    VStack(spacing:20) {
                        // Featured Businesses
                        featuredItems()
                        // Categories
                        categories()
                        // Latest 5 Business
                        latestFiveItem()
                        // Landmarks
                        landmarks()
                        // Latest 5 Events
                        latestFiveEvent()
                        
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
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func featuredItems() -> some View{
        Section {
            if #available(iOS 17.0, *) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:10) {
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
                        ForEach(Business.Category.allCases.filter { $0 != .select && $0 != .all && $0 != .other }, id:\.self) { category in
                            NavigationLink(destination: CategoryView(searchTerms: category.rawValue, categoryName:category.rawValue)) {
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
                        ForEach(Business.Category.allCases.filter { $0 != .select && $0 != .all && $0 != .other }, id:\.self) { category in
                            NavigationLink(destination: CategoryView(searchTerms: category.rawValue, categoryName:category.rawValue)) {
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
                    Text("Yaklaşan Etkinlikler")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal,20)
                        .padding(.bottom,-20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<4) { _ in
                                NavigationLink(destination: Text("Etkinlik Detayı")) {
                                    EventCardItem()
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
                    Text("Yaklaşan Etkinlikler")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal,20)
                        .padding(.bottom,10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing:10) {
                            ForEach(0..<4) { _ in
                                NavigationLink(destination: Text("Etkinlik Detayı")) {
                                    EventCardItem()
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
    func latestMovies() -> some View{
        Section {
            if #available(iOS 17.0, *) {
                VStack(alignment:.leading) {
                    Text("Vizyondaki Filmler")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal,20)
                        .padding(.bottom,-20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack() {
                            ForEach(0..<4) { _ in
                                NavigationLink(destination: Text("Film Detayı")) {
                                    MovieCardItem()
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
                    Text("Vizyondaki Filmler")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal,20)
                        .padding(.bottom,10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack() {
                            ForEach(0..<4) { _ in
                                MovieCardItem()
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
        }
    }
}

#Preview {
    ExploreView()
}
