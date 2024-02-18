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
    @Published var selectedImages = [UIImage]()
    @Published var imageURLs = [String]()
    @Published var isUploading = false
    
    @Published var businesslatitude: Double = 0
    @Published var businesslongitude: Double = 0
    
    @MainActor
    func uploadBusiness() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard isValidForm else { return }
        
        isLoadingImage = true
        await loadImages()
        
        var weekendWHSaturday: String = form.openingHourSaturday + " - " + form.closingHourSaturday
        var weekendWHSunday: String = form.openingHourSunday + " - " + form.closingHourSunday
        
        switch form.offDay {
        case .saturday:
            weekendWHSaturday = ""
        case .sunday:
            weekendWHSunday = ""
        case .weekend:
            weekendWHSaturday = ""
            weekendWHSunday = ""
        default:
            break
        }
        
        let business = Business(
            name: form.name,
            ownerUID: uid,
            owner: form.owner,
            address: form.address,
            district: form.district.rawValue,
            phone: "+90" + form.phone,
            email: form.email,
            website: form.website,
            description: form.description,
            facebook: form.facebook,
            instagram: form.instagram,
            workingHours: form.openingHour + " - " + form.closingHour,
            weekendWHSaturday: weekendWHSaturday,
            weekendWHSunday: weekendWHSunday,
            offDay: form.offDay.rawValue,
            images: imageURLs,
            coordinates: CodableCLLocationCoordinate2D(CLLocationCoordinate2D(latitude: businesslatitude, longitude: businesslongitude)),
            category: form.category.rawValue,
            createdAt: Date()
        )
        
        try await BusinessService.shared.createNewBusiness(business)
        alertItem = AlertContext.uploadSuccess
        isUploading = true
        isLoadingImage = false
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
        var openingHour = "8:00"
        var closingHour = "17:00"
        var offDay : Business.WeekDay = .sunday
        var openingHourSaturday = "Seçiniz"
        var closingHourSaturday = "Seçiniz"
        var openingHourSunday = "Seçiniz"
        var closingHourSunday = "Seçiniz"
        var category : Business.Category = .select
    }
    
    @MainActor
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
        
        guard !selectedImages.isEmpty else {
            alertItem = AlertContext.selectImage
            return false
        }
        
        guard businesslatitude != 0 && businesslongitude != 0 else {
            alertItem = AlertContext.selectLocation
            return false
        }
        
        switch form.offDay {
            case .monday where form.openingHourSaturday == "Seçiniz" || form.closingHourSaturday == "Seçiniz",
                 .tuesday where form.openingHourSaturday == "Seçiniz" || form.closingHourSaturday == "Seçiniz",
                 .wednesday where form.openingHourSaturday == "Seçiniz" || form.closingHourSaturday == "Seçiniz",
                 .thursday where form.openingHourSaturday == "Seçiniz" || form.closingHourSaturday == "Seçiniz",
                 .friday where form.openingHourSaturday == "Seçiniz" || form.closingHourSaturday == "Seçiniz",
                 .saturday where form.openingHourSunday == "Seçiniz" || form.closingHourSunday == "Seçiniz",
                 .sunday where form.openingHourSaturday == "Seçiniz" || form.closingHourSaturday == "Seçiniz",
                 .noHoliday where form.openingHourSunday == "Seçiniz" || form.closingHourSunday == "Seçiniz" || form.openingHourSaturday == "Seçiniz" || form.closingHourSaturday == "Seçiniz":
                alertItem = AlertContext.invalidWeekendHours
                return false
            default:
                return true
        }
    }
    
    @MainActor
    func loadImages() async {
        guard !selectedImages.isEmpty else { return }
        
        isLoadingImage = true
        
        do {
            imageURLs = try await ImageUploader.uploadImages(selectedImages)
        } catch {
            alertItem = AlertContext.uploadImageError
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
        if business.offDay == Business.WeekDay.noHoliday.rawValue {
            return "Tatil günü yok"
        } else {
            return "\(business.offDay) kapalı"
        }
    }
    
    func showWeekendWH(business:Business) -> String {
        let getOffDay = business.offDay
        let workingHours = business.workingHours
        
        if workingHours == business.weekendWHSaturday && workingHours == business.weekendWHSunday {
            return ""
        } else if workingHours == business.weekendWHSaturday {
            return business.weekendWHSunday.isEmpty ? "" : "Pazar: \(String(describing: business.weekendWHSunday))"
        } else if workingHours == business.weekendWHSunday {
            return business.weekendWHSaturday.isEmpty ? "" : "Cumartesi: \(String(describing: business.weekendWHSaturday))"
        } else if getOffDay == Business.WeekDay.saturday.rawValue {
            return business.weekendWHSunday.isEmpty ? "" : "Pazar: \(String(describing: business.weekendWHSunday))"
        } else if getOffDay == Business.WeekDay.sunday.rawValue {
            return business.weekendWHSaturday.isEmpty ? "" : "Cumartesi: \(String(describing: business.weekendWHSaturday))"
        } else if getOffDay == Business.WeekDay.weekend.rawValue {
            return ""
        } else {
            var result = ""
            if !business.weekendWHSaturday.isEmpty {
                result += "Cumartesi: \(String(describing: business.weekendWHSaturday))\n"
            }
            if !business.weekendWHSunday.isEmpty {
                result += "Pazar: \(String(describing: business.weekendWHSunday))"
            }
            return result
        }
    }
    
    func timePicker(selection: Binding<String>, label: String) -> some View {
        Picker(label, selection: selection) {
            Text("Seçiniz").tag("Seçiniz")
            ForEach(0..<24) { hour in
                Text("\(hour):00").tag("\(hour):00")
            }
        }
    }
}


