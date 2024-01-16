//
//  EarthquakeViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Foundation

final class EarthquakeViewModel: ObservableObject {
    
    @Published var earthquakes: [EarthquakeResponse.Earthquake] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    @MainActor
    func fetchEarthquakes() async {
        isLoading = true
        do {
            let response = try await EarthquakeService.shared.getEarthquakes()
            earthquakes = response.result
            isLoading = false
        } catch let error as APError {
            handleAPIError(error)
        } catch {
            print("Unknown error: \(error)")
        }
    }
    
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

        // Set the alertItem property to trigger the alert in the view
        self.alertItem = alertItem
    }
    
    //  Text(earthquake.dateTime) ı 16:26 şeklinde döndürür
    func getDateTime(dateTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateTime) else {
            return "Geçersiz tarih formatı"
        }
        
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    // Saati ... saat önce şeklinde döndürür
    func getHourAgo(dateTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let date = dateFormatter.date(from: dateTime) else {
            return "Geçersiz tarih formatı"
        }

        let components = Calendar.current.dateComponents([.hour,.minute,.day], from: date, to: Date())

        if let hours = components.hour, hours > 0 {
            return "\(hours) sa önce"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) dk önce"
        } else if let days = components.day, days > 0 {
            return "\(days) gün önce"
        } else {
            return "Şimdi"
        }
    }
    
}
