//
//  CreateBusinessViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

final class BusinessViewModel: ObservableObject {
    @Published var form = BusinessForm()
    @Published var image : Image?
    @Published var alertItem: AlertItem?
    @Published var isLoadingImage = false
    @Published var selectedItems = [PhotosPickerItem]()
    @Published var selectedImages = [UIImage]() {
        didSet {
            Task { await loadImages() }
        }
    }
    @Published var imageURLs = [String]()
    
    @MainActor
    func uploadBusiness() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard isValidForm else { return }
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
            images: imageURLs,
            category: form.category.rawValue,
            timestamp: Timestamp()
        )
        
        try await BusinessService.shared.createBusinessAndAddToCategory(business)
        alertItem = AlertContext.uploadSuccess
        
    }
    
    var isValidForm: Bool {
        guard !form.name.isEmpty,
              !form.owner.isEmpty,
              !form.address.isEmpty,
              !form.phone.isEmpty,
              !form.email.isEmpty,
              !form.description.isEmpty,
              form.category != .select,
              form.district != .select
        else {
            alertItem = AlertContext.requiredArea
            return false
        }
        
        guard form.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        
        guard form.phone.isPhoneValid else {
            alertItem = AlertContext.invalidPhone
            return false
        }
        
        return true
    }
    
    struct BusinessForm {
        var name = ""
        var address = ""
        var district : Business.District = .select
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
        var category : Business.Category = .select
    }
    
    @MainActor
    func loadImages() async {
        guard !selectedImages.isEmpty else { return }
        
        isLoadingImage = true
        
        do {
            imageURLs = try await ImageUploader.uploadImages(selectedImages)
        } catch {
            // Handle error
            print(error.localizedDescription)
        }
        
        isLoadingImage = false
    }
    
    func districtSuffix(district: String) -> String {
        let vowels = "aeıioöuü"
        let lastVowel = district.last(where: { vowels.contains($0) }) ?? "a"
        
        switch lastVowel {
        case "a", "ı":
            return "da"
        case "e", "i":
            return "de"
        case "o", "u":
            return "ta"
        case "ö", "ü":
            return "te"
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
}


