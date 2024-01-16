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
    @State var earthquake : EarthquakeResponse.Earthquake
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text(earthquake.title)
                    .font(.subheadline)
                    .bold()
                .padding(.bottom,2)
                Text(earthquake.locationProperties.epiCenter.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            HStack {
                VStack(alignment:.trailing) {
                    Text(viewModel.getDateTime(dateTime: earthquake.dateTime))
                        .padding(.bottom,2)
                        .font(.footnote)
                    Text("( \(viewModel.getHourAgo(dateTime: earthquake.dateTime)) )")
                        .font(.caption)
                }
                .foregroundStyle(.secondary)
                .padding(.trailing,10)
                
                Text(String(earthquake.mag))
                    .font(.title)
                    .foregroundColor(getMagnitudeColor(magnitude: earthquake.mag))
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
