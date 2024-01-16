//
//  PharmacyViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Foundation

final class PharmacyViewModel: ObservableObject {
    
    @Published var pharmacies: [PharmacyResponse] = []
    @Published var selectedPharmacy: Pharmacy?
    @Published var alertItem: AlertItem?
    @Published var showDetail = false
    @Published var isLoading = false
    
    
    func handleAPIError(_ error: APError) {
        var alertItem: AlertItem

        switch error {
        case .invalidURL:
            alertItem = AlertContext.invalidURL
        case .invalidResponse:
            alertItem = AlertContext.invalidResponse
        case .invalidData:
            alertItem = AlertContext.invalidData
        case .unableToComplete:
            alertItem = AlertContext.unableToComplete
        }
        
        self.alertItem = alertItem
    }
    
    func getAllPharmacies() async {
        isLoading = true
        do {
            let response = try await PharmacyService.shared.getPharmacies()
            pharmacies = [response]
            isLoading = false
        } catch let error as APError {
            handleAPIError(error)
        } catch {
            print("Unknown error: \(error)")
        }
    }
    
}
