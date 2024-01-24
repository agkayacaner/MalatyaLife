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
    @Published var form = BusinessForm()
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
            name: form.name,
            owner: form.owner,
            address: form.address,
            district: form.district.rawValue,
            phone: form.phone,
            email: form.email,
            website: form.website,
            description: form.description,
            facebook: form.facebook,
            instagram: form.instagram,
            twitter: form.twitter,
            workingHours: form.workingHours,
            offDay: form.offDay.rawValue,
            image: imageURL,
            category: form.category.rawValue,
            created_at: Date().timeIntervalSince1970
        )
        
        try ref.setData(from: business)
        
    }
    
    @MainActor
    func loadImage() async {
        guard let item = selectedImage else { return }
        
        isLoadingImage = true
        
        do {
            guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
            guard let uiImage = UIImage(data:imageData) else { return }
            self.image = Image(uiImage: uiImage)
            
            if let imageUrl = try await ImageUploader.uploadImage(uiImage) {
                self.imageURL = imageUrl
            }
        } catch {
            // Handle error
            print(error.localizedDescription)
        }
        
        isLoadingImage = false
    }
    
    var isValidForm: Bool {
        guard !form.name.isEmpty, !form.address.isEmpty, !form.owner.isEmpty, !form.phone.isEmpty, !form.email.isEmpty, !form.description.isEmpty, !form.workingHours.isEmpty else {
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

struct BusinessForm {
    var name = ""
    var address = ""
    var district : Business.District = .battalgazi
    var owner = ""
    var phone = ""
    var email = ""
    var website = ""
    var description = ""
    var facebook = ""
    var instagram = ""
    var twitter = ""
    var workingHours = ""
    var offDay : Business.WeekDay = .sunday
    var category : Business.Category = .cafe
}
