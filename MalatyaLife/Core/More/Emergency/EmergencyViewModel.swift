//
//  EmergencyViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import Foundation

final class EmergencyViewModel: ObservableObject {
    @Published var emergencyList: [Emergency] = []
    
    init() {}

    @MainActor
    func fetchEmergencyNumbers() async throws {
        do {
            emergencyList = try await EmergencyService.shared.fetchBusinesses()
        } catch {
            print(error.localizedDescription)
        }
    }  
}
