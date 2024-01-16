//
//  EarthquakeCellView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct EarthquakeCellView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text("Deprem Başlık")
                    .font(.subheadline)
                    .bold()
                .padding(.bottom,2)
                Text("Nerede Oldu")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            HStack {
                VStack(alignment:.trailing) {
                    Text("13:30")
                        .padding(.bottom,2)
                        .font(.footnote)
                    Text("( 1 Saat Önce )")
                        .font(.caption)
                }
                .foregroundStyle(.secondary)
                .padding(.trailing,10)
                
                Text(String("4.2"))
                    .font(.title)
                    .foregroundColor(getMagnitudeColor(magnitude: 4.2))
            }
        }
    }
}

extension EarthquakeCellView {
    func getMagnitudeColor(magnitude: Double) -> Color {
        switch magnitude {
        case 0..<3:
            return colorScheme == .dark ? .white : .black
        case 3..<4:
            return .purple
        case 4..<5:
            return .orange
        case 5...:
            return .red
        default:
            return colorScheme == .dark ? .white : .black
        }
    }
}

#Preview {
    EarthquakeCellView()
}
