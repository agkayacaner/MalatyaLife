//
//  NewsListV,ew.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 30.01.2024.
//

import SwiftUI

struct NewsListView: View {
    let width = UIScreen.main.bounds.width
    let spacing: CGFloat = 20
    
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: width / 1 - spacing, maximum: width / 1 - spacing))]
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: spacing) {
                    ForEach(0..<10) { _ in
                        NavigationLink(destination: Text("Detay")) {
                            NewsCellView()
                        }
                        .foregroundStyle(.primary)
                    }
                }
                .padding()
            }
            .refreshable {
                print("DEBUG:refresh")
            }
            .navigationTitle("Gündem")
        }
    }
}


#Preview {
    NewsListView()
}
