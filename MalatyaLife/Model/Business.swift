//
//  Business.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Firebase
import FirebaseFirestoreSwift

struct Business: Codable, Identifiable {
    @DocumentID var id: String?
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
    var images: [String]?
    var latitude: Double?
    var longitude: Double?
    var category: String
    var timestamp: Timestamp
    var isFeatured: Bool = false
    var isApproved: Bool = false
    
    var user: User?
    
    enum Category: String, CaseIterable {
        case select = "Seçiniz"
        case all = "Hepsi"
        case bakery = "Pastane"
        case bar = "Bar"
        case butcher = "Kasap"
        case cafe = "Kafe"
        case clinic = "Klinik"
        case hairdresser = "Berber"
        case hospital = "Hastane"
        case hotel = "Otel"
        case market = "Market"
        case other = "Diğer"
        case pharmacy = "Eczane"
        case petShop = "Pet Shop"
        case pub = "Pub"
        case restaurant = "Restoran"
        case tailor = "Terzi"
        case tekel = "Tekel Bayi"
    }

    
    // Malatyanın ilçeleri
    enum District: String, CaseIterable {
        case select = "Seçiniz"
        case all = "Hepsi"
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
    static let sampleBusiness01 = Business(name: "Havuç Kafe", ownerUID:"s", owner: "Sample Owner" ,address: "Karakavak mah.Güngör cad.12/h Yeşilyurt/MALATYA", district: "Yeşilyurt", phone: "131243243224", email: "mail@mail.com", website: "www.site.com", description: "Çiçek&Çikolata&Pasta&Kahvaltı-Yemek\nÇiçek siparişlerinde aynı gün adrese teslimat💐", facebook: "havuc_kafe", instagram: "havuc_kafe", twitter: "havuc_kafe", workingHours: "08.00-23.00", offDay: "Pazar", images: ["https://scontent.cdninstagram.com/v/t51.2885-15/417770454_934253834934499_5259656534685714410_n.jpg?stp=dst-jpg_e35_s1080x1080&_nc_ht=scontent.cdninstagram.com&_nc_cat=107&_nc_ohc=ias24pKJ8SMAX9F6lh6&edm=APs17CUBAAAA&ccb=7-5&oh=00_AfD8kGwCeA-2EqEjqWjlFGLpl4UwCguf-AC71nZXgWyXAw&oe=65C03A1F&_nc_sid=10d13b", "https://lh3.googleusercontent.com/p/AF1QipMCkauzhB07t1AJtLt48kjcICpKVcf6__HSMY9o=s680-w680-h510", "https://lh3.googleusercontent.com/p/AF1QipPcpqyobmUuVeYNpQCk8i6EgBduCrHtMLXnpsZQ=s680-w680-h510"] ,latitude: 0.0, longitude: 0.0, category: "Kafe", timestamp: Timestamp())
}

