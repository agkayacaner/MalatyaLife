//
//  Business.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Foundation

struct Business: Codable, Identifiable {
    var id: String?
    var name: String
    var owner: String
    var address: String
    var state: String
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
    var created_at: TimeInterval
    var isFeatured: Bool = false
    var isApproved: Bool = false
    
    enum Category: String, CaseIterable {
        case restaurant = "Restoran"
        case cafe = "Kafe"
        case hotel = "Otel"
        case market = "Market"
        case bar = "Bar"
        case other = "Diğer"
    }
    
    // Malatyanın ilçeleri
    enum State: String, CaseIterable {
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
    static let sampleBusiness01 = Business(id: "1", name: "Sample Business 01", owner: "Sample Owner" ,address: "Sample Address", state: "Sample State", phone: "Sample Phone", email: "Sample Email", website: "Sample Website", description: "Sample Description", facebook: "Sample Facebook", instagram: "Sample Instagram", twitter: "Sample Twitter", workingHours: "Sample Working Hours", offDay: "Sample Off Day", image: "Sample Image" ,latitude: 0.0, longitude: 0.0, category: "Sample Category", created_at: 0.0)
}

