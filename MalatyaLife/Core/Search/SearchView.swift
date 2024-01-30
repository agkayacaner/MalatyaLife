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
    @State var businessList : [Business] = []
    @State var searchTerms = ""
    @State var categoryName = ""
    @State var category : Business.Category = .all
    @State var district : Business.District = .all
    @State private var sort = BusinessSorter.district
    
    var filteredBusinessList : [Business] {
        return businessList.filter {
            (district == .all || $0.district == district.rawValue) &&
            (category == .all || $0.category == category.rawValue) &&
            ($0.name.contains(searchTerms) || searchTerms.isEmpty)
        }
    }


    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(filteredBusinessList) { business in
                    
                    NavigationLink(destination: BusinessDetailView(business: business).navigationBarBackButtonHidden()) {
                        BusinessCellView(business: business)
                    }
                    .foregroundStyle(.primary)
                    
                }
                Spacer()
            }
            .padding()
            .task {
                do {
                    businessList =  try await BusinessService.shared.fetchBusinesses()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .searchable(text: $searchTerms, prompt: Text("İşletmelerde Arama Yapın..."))
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
    var toolbarItems: some View {
        Menu {
            
            Picker("Sort", selection: $sort) {
                Label("İlçe", systemImage: "location")
                    .tag(BusinessSorter.district)
                Label("Kategori", systemImage: "tag")
                    .tag(BusinessSorter.category)
            }
            .pickerStyle(.inline)
            
            if case .district = sort {
                Picker("İlçe",selection: $district){
                    ForEach(Business.District.allCases, id: \.self) { district in
                        Button(action: {
                            self.district = district
                            self.searchTerms = district.rawValue
                        }) {
                            Text(district.rawValue)
                        }
                    }
                }
                .pickerStyle(.inline)
            }
            
            if case .category = sort {
                Picker("Kategori",selection: $category){
                    ForEach(Business.Category.allCases, id: \.self) { category in
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
            Label("Kategoriler", systemImage: "line.3.horizontal.decrease.circle")
        }
    }
    
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
