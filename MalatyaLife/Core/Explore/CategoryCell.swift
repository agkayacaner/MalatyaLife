//
//  CategoryCell.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 23.01.2024.
//

import SwiftUI

struct CategoryCell: View {
    @State var category : Business.Category
    
    var body: some View {
        HStack {
            Text(category.rawValue)
                .font(.subheadline)
                .padding(.horizontal,20)
                .padding(.vertical,10)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

#Preview {
    CategoryCell(category: Business.Category.cafe)
}
