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

final class BusinessViewModel: ObservableObject {
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
    @Published var isLiked = false
    @Published var likes = 0
    
    func uploadBusiness() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let business = Business(
            name: form.name,
            ownerUID: uid,
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
            workingHours: form.openingHour + " - " + form.closingHour,
            offDay: form.offDay.rawValue,
            image: imageURL,
            category: form.category.rawValue,
            timestamp: Timestamp()
        )
        
        try await BusinessService.shared.createBusiness(business)
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
        guard !form.name.isEmpty, !form.address.isEmpty, !form.owner.isEmpty, !form.phone.isEmpty, !form.email.isEmpty, !form.description.isEmpty  else {
            alertItem = AlertContext.requiredArea
            return false
        }
        
        return true
    }
    
    func districtSuffix(district: String) -> String {
        let lastVowel = district.last(where: { "aeıioöuü".contains($0) }) ?? "a"
        let lastConsonant = district.last(where: { "bcçdfgğhjklmnpqrsştwxyz".contains($0) }) ?? "b"
        
        switch (lastVowel, lastConsonant) {
        case ("a", "f"), ("a", "s"), ("a", "t"), ("a", "k"), ("a", "ç"), ("a", "ş"), ("a", "h"), ("a", "p"),
            ("ı", "f"), ("ı", "s"), ("ı", "t"), ("ı", "k"), ("ı", "ç"), ("ı", "ş"), ("ı", "h"), ("ı", "p"):
            return "ta"
        case ("e", "f"), ("e", "s"), ("e", "t"), ("e", "k"), ("e", "ç"), ("e", "ş"), ("e", "h"), ("e", "p"),
            ("i", "f"), ("i", "s"), ("i", "t"), ("i", "k"), ("i", "ç"), ("i", "ş"), ("i", "h"), ("i", "p"):
            return "te"
        case (_, "f"), (_, "s"), (_, "t"), (_, "k"), (_, "ç"), (_, "ş"), (_, "h"), (_, "p"):
            return "ta"
        default:
            return "da"
        }
    }
    
    func getOffDay(business:Business) -> String {
        if business.offDay == Business.WeekDay.noOffDay.rawValue {
            return ""
        } else {
            return "\(business.offDay) günü kapalı"
        }
    }
    
    func timePicker(selection: Binding<String>, label: String) -> some View {
        Picker(label, selection: selection) {
            ForEach(0..<24) { hour in
                Text("\(hour):00").tag("\(hour):00")
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
        var openingHour = "8:00"
        var closingHour = "17:00"
        var offDay : Business.WeekDay = .sunday
        var category : Business.Category = .cafe
    }
}


