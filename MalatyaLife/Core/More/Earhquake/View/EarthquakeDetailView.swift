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
    
    fileprivate func extractedFunc() -> some View {
        return VStack(alignment:.leading, spacing: 10) {
            HStack {
                Text(earthquake.name)
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                Text(viewModel.earthquakeFrom)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.vertical,5)
                    .padding(.horizontal,10)
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(Capsule())
            }
            .padding(.bottom)
            
            HStack {
                if earthquake.epiCenter == "" {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundStyle(.red)
                        
                        Text(earthquake.name)
                            .foregroundStyle(.secondary)
                    }
                } else {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundStyle(.red)
                        
                        Text(earthquake.epiCenter)
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
                
                    Text(viewModel.showMagnitudeWithType(earthquake: earthquake))
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
            
            Divider()
            
            HStack {
                Text(viewModel.magnitudeInfo(earthquake: earthquake))
            }
            .foregroundStyle(.secondary)
            .font(.footnote)
            .padding(.bottom, 5)
        }
        .padding(.top,30)
        .padding(.horizontal)
    }
    
    var body: some View {
        
        if #available(iOS 17.0, *) {
            VStack(alignment:.leading) {
                extractedFunc()
                
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: earthquake.lat, longitude: earthquake.lon),
                    span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                )), annotationItems: [earthquake]) { earthquake in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: earthquake.lat, longitude: earthquake.lon)) {
                        VStack {
                            Text(String(format: "%.1f", viewModel.getMagnitude(earthquake: earthquake) ))
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
                    }
                }
                .ignoresSafeArea()
            }
        } else {
            VStack(alignment:.leading) {
                extractedFunc()
                
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: earthquake.lat, longitude: earthquake.lon),
                    span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                )), annotationItems: [earthquake]) { earthquake in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: earthquake.lat, longitude: earthquake.lon)) {
                        VStack {
                            Text(String(format: "%.1f", viewModel.getMagnitude(earthquake: earthquake)))
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
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}


#Preview {
    NavigationStack {
        EarthquakeDetailView(
            viewModel: EarthquakeViewModel(),
            earthquake: EarthquakeMockData.sampleEarthquake01)
    }
}
