//
//  BusinessRequestViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore

final class BusinessRequestViewModel: ObservableObject {
    @Published var name = ""
    @Published var address = ""
    @Published var state : Business.State = .battalgazi
    @Published var owner = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var website = ""
    @Published var description = ""
    @Published var facebook = ""
    @Published var instagram = ""
    @Published var twitter = ""
    @Published var workingHours = ""
    @Published var offDay : Business.WeekDay = .sunday
    @Published var latitude = 0.0
    @Published var longitude = 0.0
    @Published var category : Business.Category = .cafe
    @Published var image : Image?
    
    @Published var alertItem: AlertItem?
    @Published var isLoadingImage = false
    @Published var imageURL = ""
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task { await loadImage() }
        }
    }
    
    @MainActor
    func submitBusiness() async throws {
        guard isValidForm else { return }
        
        let db = Firestore.firestore()
        let ref = db.collection("businesses").document()
        
        let business = Business(
            id: ref.documentID,
            name: name,
            owner: owner,
            address: address,
            state: state.rawValue,
            phone: phone,
            email: email,
            website: website,
            description: description,
            facebook: facebook,
            instagram: instagram,
            twitter: twitter,
            workingHours: workingHours,
            offDay: offDay.rawValue,
            image: imageURL,
            category: category.rawValue,
            created_at: Date().timeIntervalSince1970
        )
        
        try ref.setData(from: business)
        
    }
    
    @MainActor
    func loadImage() async {
        guard let item = selectedImage else { return }
        
        isLoadingImage = true
        
        guard let imageData = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data:imageData) else { return }
        self.image = Image(uiImage: uiImage)
        
        
        if let imageUrl = try? await ImageUploader.uploadImage(uiImage) {
            self.imageURL = imageUrl
        }
        
        isLoadingImage = false
    }
    
    var isValidForm: Bool {
        guard !name.isEmpty, !address.isEmpty, !owner.isEmpty, !phone.isEmpty, !email.isEmpty, !description.isEmpty, !workingHours.isEmpty else {
            alertItem = AlertContext.requiredArea
            return false
        }
        
        return true
    }
    
    func saveForm() async throws {
        do {
            try await submitBusiness()
        } catch {
            alertItem = AlertContext.businessDidntCreated
        }
    }
}
