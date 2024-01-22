//
//  AboutView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 20.01.2024.
//

import SwiftUI
import WebKit

struct AboutView: UIViewRepresentable {
    let url: String
        
    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        let request = URLRequest(url: URL(string: url)!)
        wkwebView.load(request)
        return wkwebView
    }
        
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

#Preview {
    AboutView(url: "https://www.malatyalife.lamamedya.com/about.php")
}
