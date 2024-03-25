//
//  Pharmacy.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Foundation

struct Pharmacy: Codable, Identifiable {
    let id: Int
    let name: String
    let address: String
    let district: String?
    let phone: String
    let description: String
}

struct PharmacyResponse: Codable {
    let data: [Pharmacy]
}

struct PharmacyMockData {
    static let samplePharmacy01 = Pharmacy(id: 1, name: "ESKİMALATYA ECZANESİ", address: "ALACAKAPI MH.TOPTAŞ CAD.MERKEZ CAMİİ ALTI NO:13/6 ESKİMALATYA /BATTALGAZİ/MALATYA", district: "BATTALGAZİ", phone: "04228412525",description: "24 SAAT AÇIK")
    
    static let samplePharmacy02 = Pharmacy(id: 2, name: "EMEKSİZ ECZANESİ",address: "ESKİ VEREM SAVAŞ DİSPANSERİ KARŞISI-ÜST EMEKSİZ", district: "BATTALGAZİ", phone: "04223228874",description: "24 SAAT AÇIK")
    
    static let samplePharmacy03 = Pharmacy(id: 3, name: "YEŞİLYURT ECZANESİ",address: "ESKİ YEŞİLYURT / ÇIRMIKTI MEYDANI (ZİRAAT BANKASI YANI)", district: "BATTALGAZİ", phone: "05393264474",description: "24 SAAT AÇIK")
    
    static let samplePharmacy04 = Pharmacy(id: 4, name: "ÖZGE ECZANESİ",address: "ÇUKURDERE MAH. ZAPÇIOĞLU CAD. NO:12/D SITMAPINARI HALK SAĞLIĞI KARŞISI", district: "BATTALGAZİ", phone: "04222121216",description: "24 SAAT AÇIK")
    
    static let pharmacies = [samplePharmacy01,samplePharmacy02, samplePharmacy03, samplePharmacy04]
}
