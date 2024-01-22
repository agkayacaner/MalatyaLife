//
//  Earthquake.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Foundation

struct Earthquake: Codable, Identifiable {
    let id: Int
    let date: String
    let lat: Double
    let lon: Double
    let depth: Double
    let magnitude: Magnitude
    let name: String
    let epiCenter: String
    
    struct Magnitude: Codable {
        let MD: Double
        let ML: Double
        let Mw: Double
    }
}

struct EarthquakeResponse: Codable {
    let data: [Earthquake]
}


struct EarthquakeMockData {
    static let sampleEarthquake01 = Earthquake(id: 1, date: "2024.01.20 18:08:06", lat: 36.0697, lon: 33.5450, depth: 1.7, magnitude: Earthquake.Magnitude(MD: 2.3, ML: 1.2, Mw: 0), name: "TURKIYE-IRAN SINIR BOLGESI", epiCenter: "")
}
