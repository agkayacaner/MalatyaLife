//
//  CustomTextField.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    @Binding var text: String
    var body: some View {
        TextField(title, text: $text)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.words)
    }
}

