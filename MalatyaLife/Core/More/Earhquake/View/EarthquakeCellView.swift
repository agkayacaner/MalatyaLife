//
//  EarthquakeCellView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct EarthquakeCellView: View {
    @StateObject var viewModel = EarthquakeViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    @State var earthquake : Earthquake
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text(earthquake.name.capitalized)
                    .font(.footnote)
                    .bold()
                    .padding(.bottom,2)
                
                if earthquake.epiCenter != "" {
                    Text(earthquake.epiCenter.capitalized)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    Text(earthquake.name.capitalized)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            HStack {
                VStack(alignment:.trailing) {
                    Text(viewModel.getTime(dateTime: earthquake.date))
                        .padding(.bottom,2)
                        .font(.footnote)
                    
                    Text("( \(viewModel.getHourAgo(dateTime: earthquake.date)) )")
                        .font(.caption)
                }
                .foregroundStyle(.secondary)
                .padding(.trailing,10)
                
                Text(viewModel.showMagnitude(earthquake: earthquake))
                    .font(.title)
                    .foregroundColor(getMagnitudeColor(magnitude: viewModel.getMagnitude(earthquake: earthquake)))
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
    EarthquakeCellView(earthquake: EarthquakeMockData.sampleEarthquake01)
}
