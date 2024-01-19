//
//  AppState.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import SwiftUI

enum AppStorageKey: String {
    case isOnboardingDone
    case isUserLoggedIn
}

final class AppState: ObservableObject {
    @AppStorage(AppStorageKey.isOnboardingDone.rawValue) var isOnboardingDone: Bool = false
    @AppStorage(AppStorageKey.isUserLoggedIn.rawValue) var isUserLoggedIn: Bool = false
}
