//
//  PharmacyService.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Foundation

class PharmacyService {
    static let shared = PharmacyService()
    
    init() {}
    
    func getPharmacies() async throws -> PharmacyResponse {
        
        let endpoint = "https://www.eczaneapi.lamamedya.com"
        
        guard let url = URL(string: endpoint) else {
            throw APError.invalidURL
        }
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            let pharmacyResponse = try decoder.decode(PharmacyResponse.self, from: data)
            
            return pharmacyResponse
        } catch let decodingError as DecodingError {
            print("Decoding error: \(decodingError)")

            throw APError.invalidData
        } catch {
            print("Unknown error: \(error)")
        
            throw APError.invalidData
        }
        
    }
}
