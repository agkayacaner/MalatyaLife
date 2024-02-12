//
//  Emergency.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import Foundation

struct Emergency: Codable, Hashable {
    let title: String
    let phone: String
}

struct EmergencyResponse: Codable {
    let emergencies: [Emergency]
}
