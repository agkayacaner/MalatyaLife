//
//  User.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: Int
    var name: String
    var lastname: String
    var email: String
    var password: String
    var createdAt: TimeInterval
}
