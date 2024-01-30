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
                        
                        
                        NavigationLink(destination: Text("Bildirimler")) {
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
                    
                    VStack(spacing:20) {
                        // Featured Businesses
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
                                .padding(.bottom, -20)
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
                        // Categories
                        Section {
                            if #available(iOS 17.0, *) {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack() {
                                        ForEach(Business.Category.allCases, id:\.self) { category in
                                            NavigationLink(destination: SearchView(searchTerms: category.rawValue, categoryName:category.rawValue)) {
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
                                        ForEach(Business.Category.allCases, id:\.self) { category in
                                            NavigationLink(destination: SearchView(searchTerms: category.rawValue, categoryName:category.rawValue)) {
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
                        // Latest 5 Business
                        Section {
                            VStack(alignment:.leading) {
                                Text("YENİ EKLENENLER")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.secondary)
                                
                                Text("Buraları keşfet")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                ForEach(viewModel.latestBusinesses.prefix(5)) { business in
                                    NavigationLink(destination: BusinessDetailView(business: business).navigationBarBackButtonHidden()) {
                                        BusinessCell(business: business)
                                    }
                                    .foregroundStyle(.primary)
                                }
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .padding(.horizontal)
                        }
                        // Latest 5 Events
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
                        // Movies on Theaters
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
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ExploreView()
}
