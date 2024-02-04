//
//  NotificationCellView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 2.02.2024.
//

import SwiftUI

struct NotificationCellView: View {
    @State var isNew = true
    
    var body: some View {
        HStack {
            Image(systemName: "b.circle.fill")
                .font(.title)
            VStack(alignment:.leading) {
                Text("Bildirim başlığı")
                    .font(.subheadline)
                Text("2 Şubat 2023 17.00")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical,3)
        .background(
            isNew ? Color(.systemGray6) : Color(.systemBackground)
        )
    }
}

#Preview {
    NotificationCellView()
}
