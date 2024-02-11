//
//  EarthquakeViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Foundation
import SwiftUI

final class EarthquakeViewModel: ObservableObject {
    @Published var earthquakes: [EarthquakeResponse] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var showDetail = false
    @Published var selectedEarthquake: Earthquake?
    @Published var earthquakeFrom : String = ""
    @Published var source: String = "AFAD"
    
    func setEarthquakeFrom(response: EarthquakeResponse) {
        self.earthquakeFrom = response.from
    }
    
    @MainActor
    func fetchFromKandilli() async {
        isLoading = true
        do {
            let response = try await EarthquakeService.shared.getEartquakeData(from: "https://www.depremapi.lamamedya.com/kandilli.php", responseType: EarthquakeResponse.self)
            earthquakes = [response]
            setEarthquakeFrom(response: response) // Bu satırı ekleyin
            objectWillChange.send()
            isLoading = false
        } catch let error as APError {
            handleAPIError(error)
        } catch {
            print("Unknown error: \(error)")
        }
    }

    @MainActor
    func fetchFromAfad() async {
        isLoading = true
        do {
            let response = try await EarthquakeService.shared.getEartquakeData(from: "https://www.depremapi.lamamedya.com/afad.php", responseType: EarthquakeResponse.self)
            earthquakes = [response]
            setEarthquakeFrom(response: response) // Bu satırı ekleyin
            objectWillChange.send()
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
        self.alertItem = alertItem
    }
    
    func getDate(dateTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateTime) else {
            return "Geçersiz tarih formatı"
        }
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getTime(dateTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateTime) else {
            return "Geçersiz tarih formatı"
        }
        
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
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
    
    func getMagnitude(earthquake: Earthquake) -> Double {
        if earthquake.magnitude.Mw > 0 {
            return earthquake.magnitude.Mw
        } else {
            let magnitudes = [earthquake.magnitude.MD, earthquake.magnitude.ML]
            let sortedMagnitudes = magnitudes.sorted(by: { $0 > $1 })
            return sortedMagnitudes.first ?? 0
        }
    }
     
    func showMagnitude(earthquake: Earthquake) -> String {
        let magnitude = getMagnitude(earthquake: earthquake)
        return String(format: "%.1f", magnitude)
    }
    
    func showMagnitudeWithType(earthquake: Earthquake) -> String {
        let magnitude = getMagnitude(earthquake: earthquake)
        var magnitudeType = "Mw"
        
        if earthquake.magnitude.Mw > 0 {
            magnitudeType = "Mw"
        } else if earthquake.magnitude.MD > earthquake.magnitude.ML {
            magnitudeType = "MD"
        } else {
            magnitudeType = "ML"
        }
        
        return String(format: "%.1f %@", magnitude, magnitudeType)
    }
}
