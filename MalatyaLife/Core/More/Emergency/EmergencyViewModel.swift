//
//  EmergencyViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import Foundation

final class EmergencyViewModel: ObservableObject {
    @Published var emergencyList: [Emergency] = []

    func fetchEmergencyNumbers() {
        EmergencyService.shared.fetchEmergencyNumbers { [weak self] result in
            switch result {
            case.success(let response):
                DispatchQueue.main.async {
                    self?.emergencyList = response.numbers
                }
            case .failure(let error):
                // TODO: - Alert
                print("Error fetching emergency numbers: \(error)")
            }
        }
    }
    
}
