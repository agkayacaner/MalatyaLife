//
//  Earthquake.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Foundation

struct EarthquakeResponse: Codable {
    let status: Bool
    let httpStatus: Int
    let serverloadms: Int
    let desc: String
    let metadata: Metadata
    let result: [Earthquake]

    struct Metadata: Codable {
        let dateStarts: String
        let dateEnds: String
        let total: Int
        
        enum CodingKeys: String, CodingKey {
            case dateStarts = "date_starts"
            case dateEnds = "date_ends"
            case total
        }
    }

    struct Earthquake: Codable, Identifiable {
        let id: String
        let earthquakeId: String
        let provider: String
        let title: String
        let date: String
        let mag: Double
        let depth: Double
        let geojson: GeoJSON
        let locationProperties: LocationProperties
        let rev: String?
        let dateTime: String
        let createdAt: Int
        let locationTZ: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case earthquakeId = "earthquake_id"
            case provider, title, date, mag, depth, geojson, rev
            case locationProperties = "location_properties"
            case dateTime = "date_time"
            case createdAt = "created_at"
            case locationTZ = "location_tz"
        }
    }

    struct GeoJSON: Codable {
        let type: String
        let coordinates: [Double]
    }

    struct LocationProperties: Codable {
        let closestCity: City
        let epiCenter: EpiCenter
        let closestCities: [City]
        let airports: [Airport]

        enum CodingKeys: String, CodingKey {
            case closestCity, epiCenter, closestCities, airports
        }
    }

    struct City: Codable {
        let name: String
        let cityCode: Int
        let distance: Double
        let population: Int?
    }

    struct EpiCenter: Codable {
        let name: String
        let cityCode: Int
        let distance: Double?
        let population: Int?
        
        init(name: String, cityCode: Int, distance: Double?, population: Int?) {
                self.name = name
                self.cityCode = cityCode
                self.distance = distance
                self.population = population
            }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            // Check if "name" key is present and not null
            if let name = try container.decodeIfPresent(String.self, forKey: .name) {
                self.name = name
            } else {
                // Provide a default value if "name" is null
                self.name = "Unknown"
            }

            // Check if "cityCode" is present and not equal to -1
            if let cityCode = try container.decodeIfPresent(Int.self, forKey: .cityCode), cityCode != -1 {
                self.cityCode = cityCode
            } else {
                // Provide a default value or handle the case when "cityCode" is -1 or not present
                self.cityCode = -1  // You can set a different default value or handle it according to your logic
            }

            distance = try container.decodeIfPresent(Double.self, forKey: .distance)
            population = try container.decodeIfPresent(Int.self, forKey: .population)
        }
    }

    struct Airport: Codable {
        let distance: Double
        let name: String
        let code: String
        let coordinates: GeoJSON
    }
}

struct EarthquakeMockData {
    static let sampleEarthquake01 = EarthquakeResponse.Earthquake(
        id: "65909365d5d72577a5cb0835",
        earthquakeId: "v3Q8hSXhLopoc",
        provider: "kandilli",
        title: "GOLKOY-(ELAZIG)",
        date: "2023.12.31 00:44:04",
        mag: 1.3,
        depth: 1.7,
        geojson: EarthquakeResponse.GeoJSON(type: "Point", coordinates: [37.3122, 38.5335]),
        locationProperties: EarthquakeResponse.LocationProperties(
            closestCity: EarthquakeResponse.City(name: "Kahramanmaraş", cityCode: 46, distance: 73874.67409807493, population: 1177436),
            epiCenter: EarthquakeResponse.EpiCenter(name: "Malatya", cityCode: 44, distance: nil, population: 812580),
            closestCities: [EarthquakeResponse.City(name: "Kahramanmaraş", cityCode: 46, distance: 73874.67409807493, population: 1177436)],
            airports: [EarthquakeResponse.Airport(
                distance: 68659.33364766886,
                name: "Erhaç Havalimanı",
                code: "MLX",
                coordinates: EarthquakeResponse.GeoJSON(type: "Point", coordinates: [38.091, 38.4354])
            )]
        ),
        rev: nil,
        dateTime: "2023-12-31 00:44:04",
        createdAt: 1703979844,
        locationTZ: "Europe/Istanbul"
    )
}
