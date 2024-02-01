//
//  String+Ext.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 1.02.2024.
//

import Foundation
import RegexBuilder

extension String {
    // NSPredicate, bir nesnenin özelliklerini sorgulamak için kullanılır. Örneğin bir nesnenin özelliği olan bir stringin uzunluğu 5 ten büyük müdür? gibi.
    
//    var isValidEmail: Bool {
//        let emailFormat = "[A-Z0-9a-z.%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
//
//        return emailPredicate.evaluate(with: self)
//    }
    
    var isPhoneValid: Bool {
        let phoneFormat = "[0-9]{10}"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneFormat)
        
        return phonePredicate.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailRegex = Regex {
            OneOrMore {
                CharacterClass(
                    .anyOf(".%+-"),
                    ("A"..."Z"),
                    ("0"..."9"),
                    ("a"..."z")
                )
            }
            "@"
            OneOrMore {
                CharacterClass(
                    .anyOf("-"),
                    ("A"..."Z"),
                    ("a"..."z"),
                    ("0"..."9")
                )
            }
            "."
            Repeat(2...64) {
                CharacterClass(
                    ("A"..."Z"),
                    ("a"..."z")
                )
            }
        }
        return self.wholeMatch(of: emailRegex) != nil
    }
}
