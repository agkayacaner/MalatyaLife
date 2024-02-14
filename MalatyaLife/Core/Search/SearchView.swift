//
//  SearchView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI
import Kingfisher
import Firebase
import FirebaseFirestoreSwift

public enum BusinessSorter: Hashable {
    case district
    case category
}

struct SearchView: View {
    @State private var businessList : [Business] = []
    @State var searchTerms = ""
    @State var categoryName = ""
    @State private var category : Business.Category = .all
    @State private var district : Business.District = .all
    @State private var sort = BusinessSorter.district
    
    private var filteredBusinessList : [Business] {
        return businessList.filter {
            (district == .all || $0.district == district.rawValue) &&
            (category == .all || $0.category == category.rawValue) &&
            ($0.name.contains(searchTerms) || searchTerms.isEmpty)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if searchTerms.isEmpty {
                    ForEach(filteredBusinessList) { business in
                        NavigationLink(destination: BusinessDetailView(business: business).navigationBarBackButtonHidden()) {
                            BusinessCellView(business: business)
                        }
                        .foregroundStyle(.primary)
                    }
                    .listRowSeparator(.hidden)
                } else {
                    ForEach(filteredBusinessList) { business in
                        NavigationLink(destination: BusinessDetailView(business: business).navigationBarBackButtonHidden()) {
                            BusinessCellView(business: business)
                        }
                        .foregroundStyle(.primary)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchTerms, prompt: Text("Ara..."))
            .overlay {
                if #available(iOS 17, *){
                    if filteredBusinessList.isEmpty {
                        ContentUnavailableView.search(text: searchTerms)
                    }
                }
            }
            .task {
                do {
                    businessList =  try await BusinessService.shared.fetchBusinesses()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .navigationTitle(categoryName.isEmpty ? "Ara" : "\(categoryName) Kategorisi")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    toolbarItems
                }
            }
        }
    }
    
    @ViewBuilder
    private var toolbarItems: some View {
        Menu {
            
            Picker("Sort", selection: $sort) {
                Label("İlçe", systemImage: "map")
                    .tag(BusinessSorter.district)
                Label("Kategori", systemImage: "square.stack")
                    .tag(BusinessSorter.category)
            }
            
            if case .district = sort {
                Picker("İlçe",selection: $district){
                    ForEach(Business.District.allCases.filter { $0 != .select }, id: \.self) { district in
                        Button(action: {
                            self.district = district
                            self.searchTerms = district.rawValue
                        }) {
                            Text(district.rawValue)
                        }
                    }
                }
            }
            
            if case .category = sort {
                Picker("Kategori",selection: $category){
                    ForEach(Business.Category.allCases.filter { $0 != .select && $0 != .other }, id: \.self) { category in
                        Button(action: {
                            self.category = category
                            self.searchTerms = category.rawValue
                        }) {
                            Text(category.rawValue)
                        }
                    }
                }
                .pickerStyle(.inline)
            }
            
        } label: {
            Label("Kategoriler", systemImage: "slider.horizontal.3")
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
