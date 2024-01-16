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
    let dismissButton: Alert.Button
}


struct AlertContext {
    //MARK: - Network Alerts
    static let invalidData = AlertItem(title: Text("Sunucu Hatası"),
                                       message: Text("Sunucudan alınan veri geçersizdi. Lütfen destekle iletişime geçin."),
                                       dismissButton: .default(Text("Tamam")))

    static let invalidResponse = AlertItem(title: Text("Sunucu Hatası"),
                                           message: Text("Sunucudan geçersiz yanıt. Lütfen daha sonra tekrar deneyin veya destekle iletişime geçin."),
                                           dismissButton: .default(Text("Tamam")))

    static let invalidURL = AlertItem(title: Text("Sunucu Hatası"),
                                      message: Text("Sunucuya bağlanmada bir sorun oluştu. Eğer bu sorun devam ederse lütfen destekle iletişime geçin."),
                                      dismissButton: .default(Text("Tamam")))

    static let unableToComplete = AlertItem(title: Text("Sunucu Hatası"),
                                            message: Text("Şu anda isteğinizi tamamlayamıyoruz. Lütfen internet bağlantınızı kontrol edin."),
                                            dismissButton: .default(Text("Tamam")))

}

