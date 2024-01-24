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
                VStack(){
                    // Header
                    HStack {
                        VStack(alignment:.leading,spacing: 10){
                            Text("Merhaba")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("Bugün \(getDate())")
                                .font(.subheadline)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                        }
                        
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing:30) {
                        // Featured Businesses
                        if #available(iOS 17.0, *) {
                            Section {
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
                            }
                        }
                        
                        // Categories
                        if #available(iOS 17.0, *) {
                            Section {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack() {
                                        ForEach(Business.Category.allCases, id:\.self) { category in
                                            CategoryCell(category: category)
                                        }
                                    }
                                    .scrollTargetLayout()
                                }
                                .scrollTargetBehavior(.viewAligned)
                                .contentMargins(20, for: .scrollContent)
                                .listRowInsets(EdgeInsets())
                            }
                            .padding(.vertical,-50)
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
                        if #available(iOS 17.0, *) {
                            Section {
                                VStack(alignment:.leading) {
                                    Text("Yaklaşan Etkinlikler")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .padding(.horizontal,20)
                                        .padding(.bottom,-20)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack() {
                                            ForEach(0..<4) { _ in
                                                EventCardItem()
                                            }
                                        }
                                        .scrollTargetLayout()
                                    }
                                    .scrollTargetBehavior(.viewAligned)
                                    .contentMargins(20, for: .scrollContent)
                                    .listRowInsets(EdgeInsets())
                                }
                            }
                        }
                        
                        // Movies on Theaters
                        if #available(iOS 17.0, *) {
                            Section {
                                VStack(alignment:.leading) {
                                    Text("Vizyondaki Filmler")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .padding(.horizontal,20)
                                        .padding(.bottom,-20)
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack() {
                                            ForEach(0..<4) { _ in
                                                MovieCardItem()
                                            }
                                        }
                                        .scrollTargetLayout()
                                    }
                                    .scrollTargetBehavior(.viewAligned)
                                    .contentMargins(20, for: .scrollContent)
                                    .listRowInsets(EdgeInsets())
                                }
                            }
                        }
                    }
                   
                    Spacer()
                    
                    // Main View
                }
            }
            
        }
    }
}

extension ExploreView {
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    ExploreView()
}
