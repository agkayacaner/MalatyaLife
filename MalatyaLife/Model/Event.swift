//
//  Event.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 14.02.2024.
//

import Firebase
import FirebaseFirestoreSwift

struct Event: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var image: String?
    var date: String
    var time: String
    var location: String
    var createdAt: Date
    var isFeatured: Bool
}

struct EventMockData {
    static let events = [
        Event(id: "34asd213apıf", name: "Ezginin Günlüğü", description: "Anne babasını tanımadığı için gökteki yıldızlardan doğduğuna inanan, denizin kucağında bir sokak çocuğu olarak büyüyen, Galata mevkiinde karnını doyurabilmek için “icra-i sanat” eyleyen Cevriye, sıradan bir sokak kızı değil aslında İstanbul sokaklarının ta kendisidir. Hastalık ve soğuktan ölüme yaklaştığı o gece, karşısına çıkan esrarengiz bir Adam sayesinde hayata ve kara sevdaya tutunur.", image: "https://b6s54eznn8xq.merlincdn.net/Uploads/Films/ezginin-gunlugu-202419162157b8d8e9d50364801892c53d31a637c5f.jpg", date: "2024-02-25", time: "20:00", location: "Kongre Kültür Merkezi",createdAt: Date(), isFeatured: true),
    ]
}
