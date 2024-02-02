//
//  Alert.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//


import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let primaryButton: Alert.Button
    let secondaryButton: Alert.Button?
}


struct AlertContext {
    //MARK: - Network Alerts
    static let invalidData = AlertItem(title: Text("Sunucu Hatası"),
                                       message: Text("Sunucudan alınan veri geçersizdi. Lütfen destekle iletişime geçin."),
                                       primaryButton: .default(Text("Tamam")), secondaryButton: nil)

    static let invalidResponse = AlertItem(title: Text("Sunucu Hatası"),
                                           message: Text("Sunucudan geçersiz yanıt. Lütfen daha sonra tekrar deneyin veya destekle iletişime geçin."),
                                           primaryButton: .default(Text("Tamam")), secondaryButton: nil)

    static let invalidURL = AlertItem(title: Text("Sunucu Hatası"),
                                      message: Text("Sunucuya bağlanmada bir sorun oluştu. Eğer bu sorun devam ederse lütfen destekle iletişime geçin."),
                                      primaryButton: .default(Text("Tamam")), secondaryButton: nil)

    static let unableToComplete = AlertItem(title: Text("Sunucu Hatası"),
                                            message: Text("Şu anda isteğinizi tamamlayamıyoruz. Lütfen internet bağlantınızı kontrol edin."),
                                            primaryButton: .default(Text("Tamam")), secondaryButton: nil)

    static let requiredArea = AlertItem(title: Text("Alanları Doldurun"), message: Text("Devam edebilmek için gerekli alanları doldurun!"), primaryButton: .default(Text("Tamam")), secondaryButton: nil)
    
    static let invalidEmail = AlertItem(title: Text("Geçersiz E-Posta"), message: Text("Lütfen geçerli bir e-posta adresi girin!"), primaryButton: .default(Text("Tamam")), secondaryButton: nil)
    
    static let invalidPhone = AlertItem(title: Text("Geçersiz Telefon Numarası"), message: Text("Lütfen geçerli bir telefon numarası girin!"), primaryButton: .default(Text("Tamam")), secondaryButton: nil)
    
    static let selectImage = AlertItem(title: Text("Resim Seçin"), message: Text("İşletmenin resmini seçin!"), primaryButton: .default(Text("Tamam")), secondaryButton: nil)
    
    static let uploadSuccess = AlertItem(title: Text("Başarılı"), message: Text("İşletme başvurunuz alındı, onay sürecinden sonra aktif olacaktır!"), primaryButton: .default(Text("Tamam")), secondaryButton: nil)
}

