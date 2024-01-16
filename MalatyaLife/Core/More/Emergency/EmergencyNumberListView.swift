//
//  EmergencyNumberListView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct EmergencyNumberListView: View {
    var body: some View {
        List {
            ForEach(0 ..< 10) { number in
                Button(action: {
                    guard let url = URL(string: "tel://\(number)") else { return }
                    UIApplication.shared.open(url)
                }, label: {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("0\(number)")
                    }
                })
            }
        }
        .listStyle(.plain)
        .navigationTitle("Önemli Telefonlar")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        EmergencyNumberListView()
    }
}
