//
//  EarthquakeDetailView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 21.01.2024.
//

import SwiftUI
import MapKit

struct EarthquakeDetailView: View {
    @StateObject var viewModel: EarthquakeViewModel
    @State var earthquake: Earthquake
    @State private var isAnimating = false
    
    var body: some View {
        if #available(iOS 17.0, *) {
            VStack(alignment:.leading) {
                VStack(alignment:.leading, spacing: 10) {
                    HStack {
                        Text(earthquake.name)
                            .font(.title3)
                            .bold()
                        
                        Spacer()
                        
                        Text("Kandilli")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .padding(.vertical,5)
                            .padding(.horizontal,10)
                            .background(Color.secondary.opacity(0.2))
                            .clipShape(Capsule())
                    }
                    .padding(.bottom)
                    
                    HStack {
                        if earthquake.epiCenter == " " {
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundStyle(.red)
                                
                                Text(earthquake.epiCenter)
                                    .foregroundStyle(.secondary)
                            }
                        } else {
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundStyle(.red)
                                
                                Text(earthquake.name)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        Spacer()
                        
                        Text("\(viewModel.getDate(dateTime: earthquake.date))")
                            .foregroundStyle(.secondary)
                        
                        Text("\(viewModel.getTime(dateTime: earthquake.date))")
                            .bold()
                    }
                    .font(.footnote)
                    
                    Divider()
                    
                    HStack {
                        Text("Büyüklük")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        showMagnitude()
                            .bold()
                        
                    }
                    .font(.footnote)
                    
                    Divider()
                    
                    HStack {
                        Text("Derinlik")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(String(format: "%.1f", earthquake.depth) + " km")
                            .bold()
                    }
                    .font(.footnote)
                    
                }
                .padding(.top,30)
                .padding(.horizontal)
                
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: earthquake.lat, longitude: earthquake.lon),
                    span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                )), annotationItems: [earthquake]) { earthquake in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: earthquake.lat, longitude: earthquake.lon)) {
                        VStack {
                            ExtractedView(earthquake: earthquake)
                        }
                    }
                }
                .ignoresSafeArea()
            }
        } else {
            VStack(alignment:.leading) {
                VStack(alignment:.leading, spacing: 10) {
                    Text(earthquake.name)
                        .font(.title2)
                    
                    HStack {
                        Text(earthquake.epiCenter)
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                        
                        Spacer()
                        
                        Text("\(viewModel.getDate(dateTime: earthquake.date))")
                            .foregroundColor(Color.secondary)
                        
                        Text("\(viewModel.getTime(dateTime: earthquake.date))")
                            .bold()
                    }
                }
                .padding(.vertical,30)
                .padding(.horizontal)
                
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: earthquake.lat, longitude: earthquake.lon),
                    span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                )), annotationItems: [earthquake]) { earthquake in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: earthquake.lat, longitude: earthquake.lon)) {
                        VStack {
                            ExtractedView(earthquake: earthquake)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            
        }
    }
    
    func showMagnitude() -> some View {
        if earthquake.magnitude.Mw > 0 {
            return Text(String(format: "%.1f", earthquake.magnitude.Mw) + " " + "Mw")
        } else {
            let magnitudes = ["MD" : earthquake.magnitude.MD, "ML" : earthquake.magnitude.ML]
            
            let sortedMagnitudes = magnitudes.sorted(by: { $0.value > $1.value })
            
            for magnitude in sortedMagnitudes {
                return Text(String(format: "%.1f", magnitude.value) + " " + magnitude.key)
            }
            
        }
        
        return Text("0")
    }
}


#Preview {
    NavigationStack {
        EarthquakeDetailView(
            viewModel: EarthquakeViewModel(),
            earthquake: EarthquakeMockData.sampleEarthquake01)
    }
}

struct ExtractedView: View {
    @State var earthquake: Earthquake
    @State private var isAnimating = false
    
    var body: some View {
        Text(String(format: "%.1f", Double(getMagnitude())!))
            .foregroundColor(.white)
            .font(.subheadline)
            .padding(4)
            .background(Color.red)
            .clipShape(Circle())
            .opacity(0.8)
            .padding(10)
            .background(Color.red.opacity(isAnimating ? 0.5 : 0.3))
            .clipShape(Circle())
            .scaleEffect(isAnimating ? 1.0 : 0.8)
            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
            .onAppear() {
                self.isAnimating = true
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
}
