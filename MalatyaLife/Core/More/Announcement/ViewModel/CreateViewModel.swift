//
//  CreateViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 22.02.2024.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class CreateViewModel: ObservableObject {
    @Published var businesses = [Business]()
    @Published var selectedBusinessID = ""
    @Published var form = AnnouncementForm()
    
    @Published var isLoading: Bool = false
    @Published var oneDay = false
    @Published var alertItem: AlertItem?
    
    init() {
        Task {
            do {
                try await fetchBusinesses()
            } catch {
                print("Error fetching businesses: \(error)")
            }
        }
    }
    
    @MainActor
    func createNewAnnouncement() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard isValidForm else { return }
        
        if oneDay {
            form.endDate = form.startDate
        }
        
        let announcement = Announcement(
            name: form.name,
            description: form.description,
            category: form.category.rawValue,
            startDate: form.startDate,
            endDate: form.endDate,
            businessID: selectedBusinessID,
            ownerUID: uid
        )
        
        try await AnnouncementService.shared.createAnnouncement(announcement)
        alertItem = AlertContext.uploadSuccess
    }
    
    @MainActor
    var isValidForm: Bool {
        guard !form.name.isEmpty,
              !form.description.isEmpty,
              form.category != .select
        else {
            alertItem = AlertContext.requiredArea
            return false
        }
        return true
    }
    
    class AnnouncementForm {
        var name = ""
        var description = ""
        var category : Announcement.Category = .select
        var startDate = Date()
        var endDate = Date()
    }
    
    @MainActor
    func fetchBusinesses() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let querySnapshot = try await Firestore.firestore().collection("businesses")
            .whereField("ownerUID", isEqualTo: uid)
            .whereField("isActive", isEqualTo: true)
            .whereField("isApproved", isEqualTo: true)
            .getDocuments()
        
        businesses = querySnapshot.documents.compactMap { document in
            try? document.data(as: Business.self)
        }
        
        selectedBusinessID = businesses.first?.id ?? ""
    }
    
    func getAnnouncementName(announcement: Announcement) -> any View {
        if announcement.category == "Canlı Müzik" {
            return AnyView(Text(announcement.name).font(.title2).fontWeight(.semibold).foregroundColor(.red))
        } else if announcement.category == "Sahne Sanatları" {
            return AnyView(Text(announcement.name).font(.title2).fontWeight(.semibold).foregroundColor(.blue))
        } else if announcement.category == "Sergi" {
            return AnyView(Text(announcement.name).font(.title2).fontWeight(.semibold).foregroundColor(.green))
        } else if announcement.category == "Spor" {
            return AnyView(Text(announcement.name).font(.title2).fontWeight(.semibold).foregroundColor(.orange))
        } else {
            return AnyView(Text(announcement.name).font(.title2).fontWeight(.semibold).foregroundColor(.primary))
        }
    }
}
