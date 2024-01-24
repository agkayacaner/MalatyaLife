//
//  ExploreViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 23.01.2024.
//

import Foundation

final class ExploreViewModel: ObservableObject {
    
    @Published var featuredBusinesses : [Business] = []
    @Published var latestBusinesses : [Business] = []
    @Published var selectedBusiness : Business?
    
    init() {
        Task {
            do {
                try await fetchLatestBusinesses()
                try await fetchFeaturedItems()
            } catch {
                print("Hata: \(error)")
            }
        }
    }
    
    @MainActor
    func fetchLatestBusinesses() async throws {
        do {
            latestBusinesses = try await BusinessService.shared.fetchBusinesses()
        } catch {
            print("Hata")
            throw error
        }
    }
    
    
    @MainActor
    func fetchFeaturedItems() async throws {
        do {
            featuredBusinesses = try await BusinessService.shared.fetchFeaturedBusinesses()
        } catch {
            print("Hata")
            throw error
        }
    }
}
