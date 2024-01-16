//
//  SearchView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct SearchView: View {
    @State var searchTerms = ""
    var body: some View {
        NavigationStack {
            VStack {
                // TODO: - Featured Search Items
            }
            .searchable(text: $searchTerms, prompt: Text("Ara"))
            .navigationTitle("Ara")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
