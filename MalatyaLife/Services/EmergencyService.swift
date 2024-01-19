//
//  EmergencyService.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import Foundation
import Firebase

class EmergencyService {
    
    static let shared = EmergencyService()
    
    init() {}
    
    func fetchEmergencyNumbers(completion: @escaping (Result<EmergencyResponse, Error>) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("emergencyphones").document("dxlMQU4KkxPV4xWllbUS").getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document, document.exists, let data = document.data(), let numbersData = try? JSONSerialization.data(withJSONObject: data["numbers"] ?? [], options: []) else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let numbers = try decoder.decode([Emergency].self, from: numbersData)
                let response = EmergencyResponse(numbers: numbers)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
}
