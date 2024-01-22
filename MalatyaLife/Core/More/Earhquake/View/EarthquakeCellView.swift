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
                Text(earthquake.name)
                    .font(.footnote)
                    .bold()
                .padding(.bottom,2)
                
                if earthquake.epiCenter != "" {
                    Text(earthquake.epiCenter)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    Text(earthquake.name)
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

                showMagnitude()
                    .font(.title)
                    .foregroundColor(getMagnitudeColor(magnitude: Double(getMagnitude())!))
            }
        }
    }
    
    func getMagnitude() -> String {
        if earthquake.magnitude.Mw > 0 {
            return String(format: "%.1f", earthquake.magnitude.Mw)
        } else {
            let magnitudes = [earthquake.magnitude.MD, earthquake.magnitude.ML]
            
            let sortedMagnitudes = magnitudes.sorted(by: { $0 > $1 })
            
            for magnitude in sortedMagnitudes {
                return String(format: "%.1f", magnitude)
            }
        }
        return "0"
    }
    
    func showMagnitude() -> some View {
        if earthquake.magnitude.Mw > 0 {
            return Text(String(format: "%.1f", earthquake.magnitude.Mw))
        } else {
            let magnitudes = [earthquake.magnitude.MD, earthquake.magnitude.ML]
            
            let sortedMagnitudes = magnitudes.sorted(by: { $0 > $1 })
            
            for magnitude in sortedMagnitudes {
                return Text(String(format: "%.1f", magnitude))
            }
            
        }
        
        return Text("0")
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
