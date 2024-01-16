//
//  ExploreView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                Section {
                    HStack(alignment:.lastTextBaseline) {
                        VStack(alignment:.leading) {
                            Text("Merhaba")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("Bugün \(getDate())")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()

                    }
                    .padding()
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
