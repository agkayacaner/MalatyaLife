//
//  CategoryView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 31.01.2024.
//

import SwiftUI
import Kingfisher
import Firebase
import FirebaseFirestoreSwift

public enum CategoryViewSorter: Hashable {
    case district
}

struct CategoryView: View {
    @State private var businessList : [Business] = []
    @State var searchTerms = ""
    @State var categoryName = ""
    @State private var category : Business.Category = .all
    @State private var district : Business.District = .all
    @State private var sort = CategoryViewSorter.district
    
    private var filteredBusinessList : [Business] {
        return businessList.filter {
            (district == .all || $0.district == district.rawValue) &&
            ($0.category.contains(searchTerms) || searchTerms.isEmpty)
        }
    }
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(filteredBusinessList) { business in
                    NavigationLink(destination: BusinessDetailView(business: business).navigationBarBackButtonHidden()) {
                        BusinessCellView(business: business)
                    }
                    .foregroundStyle(.primary)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .task {
                do {
                    businessList =  try await BusinessService.shared.fetchBusinesses()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .navigationTitle(pluralize(categoryName))
            .navigationBarTitleDisplayMode(.large)
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
                Label("İlçe", systemImage: "location")
                    .tag(CategoryViewSorter.district)
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
            
        } label: {
            Label("Kategoriler", systemImage: "line.3.horizontal.decrease.circle")
        }
    }
    
    private func pluralize(_ word: String) -> String {
        let lastVowel = word.lowercased().last(where: {"aeıioöuü".contains($0)})
        switch lastVowel {
        case "a", "ı", "o", "u":
            return word + "lar"
        case "e", "i", "ö", "ü":
            return word + "ler"
        default:
            return word
        }
    }
}

#Preview {
    CategoryView()
}
