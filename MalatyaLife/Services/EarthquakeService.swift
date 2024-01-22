//
//  EarthquakeService.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Foundation

class EarthquakeService {
    
    static let shared = EarthquakeService()
    
    init() {}
    
    func getEarthquakes() async throws -> EarthquakeResponse {
        
        let endpoint = "https://www.depremapi.lamamedya.com"
        
        guard let url = URL(string: endpoint) else {
            throw APError.invalidURL
        }
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            let earthquakeResponse = try decoder.decode(EarthquakeResponse.self, from: data)
            
            return earthquakeResponse
        } catch let decodingError as DecodingError {
            print("Decoding error: \(decodingError)")

            throw APError.invalidData
        } catch {
            print("Unknown error: \(error)")
        
            throw APError.invalidData
        }
        
    }
    
//    func getEarthquakes() async throws -> EarthquakeResponse {
//        
//        let endpoint = "https://api.orhanaydogdu.com.tr/deprem/kandilli/live"
//        
//        guard let url = URL(string: endpoint) else {
//            throw APError.invalidURL
//        }
//        
//        do {
//            let (data, urlResponse) = try await URLSession.shared.data(from: url)
//            
//            guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                throw APError.invalidResponse
//            }
//            
//            let decoder = JSONDecoder()
//            let earthquakeResponse = try decoder.decode(EarthquakeResponse.self, from: data)
//            
//            return earthquakeResponse
//        } catch let decodingError as DecodingError {
//            print("Decoding error: \(decodingError)")
//
//            throw APError.invalidData
//        } catch {
//            print("Unknown error: \(error)")
//
//            throw APError.invalidData
//        }
//    }
}
