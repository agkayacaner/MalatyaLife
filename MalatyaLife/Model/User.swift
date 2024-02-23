//
//  User.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var name: String
    var lastname: String
    var email: String
    var isAdmin: Bool = false
    var profileImage: String?
    var businesses: [String]
    var createdAt: Date
}
