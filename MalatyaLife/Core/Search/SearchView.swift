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

struct SearchView: View {
    @State var businessList : [Business] = []
    @State var searchTerms = ""
    @State var categoryName = ""
    
    var filteredBusinessList : [Business] {
        guard !searchTerms.isEmpty else { return businessList }
        return businessList.filter { $0.name.localizedStandardContains(searchTerms) || $0.category.localizedStandardContains(searchTerms) }
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
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
