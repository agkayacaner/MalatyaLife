//
//  Business.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Firebase
import FirebaseFirestoreSwift

struct Business: Codable, Identifiable {
    @DocumentID var businessId: String?
    var id: String? {
        return businessId ?? NSUUID().uuidString
    }
    var name: String
    var ownerUID: String
    var owner: String
    var address: String
    var district: String
    var phone: String
    var email: String
    var website: String?
    var description: String
    var facebook: String?
    var instagram: String?
    var twitter: String?
    var workingHours: String
    var offDay: String
    var image: String?
    var latitude: Double?
    var longitude: Double?
    var category: String
    var likes : Int
    var timestamp: Timestamp
    var isFeatured: Bool = false
    var isApproved: Bool = false
    
    var user: User?
    
    enum Category: String, CaseIterable {
        case restaurant = "Restoran"
        case cafe = "Kafe"
        case hotel = "Otel"
        case market = "Market"
        case bar = "Bar"
        case other = "Diğer"
    }
    
    // Malatyanın ilçeleri
    enum District: String, CaseIterable {
        case akcadag = "Akçadağ"
        case arguvan = "Arguvan"
        case battalgazi = "Battalgazi"
        case darende = "Darende"
        case dogansehir = "Doğanşehir"
        case doganyol = "Doğanyol"
        case hekimhan = "Hekimhan"
        case kale = "Kale"
        case kuluncak = "Kuluncak"
        case pütürge = "Pütürge"
        case yesilyurt = "Yeşilyurt"
        case yazihan = "Yazıhan"
    }
    
    // Haftanın 7 Günü
    enum WeekDay: String, CaseIterable {
        case monday = "Pazartesi"
        case tuesday = "Salı"
        case wednesday = "Çarşamba"
        case thursday = "Perşembe"
        case friday = "Cuma"
        case saturday = "Cumartesi"
        case sunday = "Pazar"
        case noOffDay = "Tatil Günü Yok"
    }
}

struct BusinessMockData {
    static let sampleBusiness01 = Business(name: "Havuç Kafe", ownerUID:"s", owner: "Sample Owner" ,address: "Karakavak mah.Güngör cad.12/h Yeşilyurt/MALATYA", district: "Yeşilyurt", phone: "131243243224", email: "mail@mail.com", website: "www.site.com", description: "Çiçek&Çikolata&Pasta&Kahvaltı-Yemek\nÇiçek siparişlerinde aynıgün adrese teslimat💐", facebook: "havuc_kafe", instagram: "havuc_kafe", twitter: "havuc_kafe", workingHours: "08.00-23.00", offDay: "Pazar", image: "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2894&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ,latitude: 0.0, longitude: 0.0, category: "Kafe", likes: 123, timestamp: Timestamp())
}

