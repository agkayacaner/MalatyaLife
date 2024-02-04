//
//  NotificationView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 2.02.2024.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<10){ notification in
                NotificationCellView()
            }
        }
        .navigationTitle("Bildirimler")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NotificationView()
    }
}
