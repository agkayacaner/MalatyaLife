//
//  Category.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 31.01.2024.
//

import FirebaseFirestoreSwift

struct Category: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var businesses: [String]?
}
