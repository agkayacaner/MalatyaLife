//
//  OnboardingView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 19.01.2024.
//

import SwiftUI

struct Onboarding: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var description: String
}

struct OnboardingView: View {
    
    @EnvironmentObject private var appState: AppState
    @State private var currentPage = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            appState.isOnboardingDone = true
                        }, label: {
                            Text("Geç")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .cornerRadius(10)
                        })
                    }
                    .padding(.top,40)
                    
                    TabView(selection: $currentPage) {
                        ForEach(onBoardings.indices, id:\.self) { item in
                            OnboardingCardView(item: onBoardings[item])
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    if currentPage == onBoardings.count - 1 {
                        
                        NavigationLink(destination: LoginView()) {
                            Text("Giriş Yap / Kayıt Ol")
                                .font(.headline)
                        }
                        .padding(.bottom,20)
                    }
                    
                    HStack() {
                        HStack(spacing: 10) {
                            ForEach(onBoardings.indices, id:\.self) { index in
                                Group {
                                    if currentPage == index {
                                        RoundedRectangle(cornerRadius: 14)
                                            .fill(Color.accentColor)
                                            .frame(width: 30, height: 8)
                                    } else {
                                        Circle()
                                            .fill(Color.gray)
                                            .frame(width: 8, height: 8)
                                    }
                                }
                                .onChange(of: currentPage) { _ in
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            if currentPage < onBoardings.count - 1 {
                                currentPage += 1
                            } else {
                                appState.isOnboardingDone = true
                            }
                        }, label: {
                            Text(currentPage < onBoardings.count - 1 ? "İleri" : "Başla >")
                        })
                        
                    }
                    .padding(40)
          
                }.ignoresSafeArea()
            }
        }
    }
}

struct OnboardingCardView: View {

    var item: Onboarding
    
    var body: some View {
        VStack {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 20)
            
            Text(item.title)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Text(item.description)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.top, 5)
        }
        .tag(item.id)
    }
}

private let onBoardings = [
    Onboarding(
        image: "explore",
        title: "Malatya'yı Keşfet",
        description: "Malatya'da ki tüm mekan ve işletmeleri keşfedebilir, yeni etkinliklerden haberdar olabilirsin."
    ),
    Onboarding(
        image: "more",
        title: "İhtiyacın olanlar burada",
        description: "Nöbetçi eczaneler, önemli numaralar, kurumlar, son depremler ihtiyacın olan şeyler tek bir yerde."
    ),
    Onboarding(
        image: "newbusiness",
        title: "İşletmeni Ekle",
        description: "Deprem sonrası işletmenizin yeri değişmiş olabilir, müşterilerinizin sizi kolayca bulması için işletmenizi ekleyin."
    ),
    Onboarding(
        image: "login-screen",
        title: "Hesap Oluştur",
        description: "Malatya Life uygulamasının tüm özellikleriyle kullanmak için bir hesaba ihtiyacın var."
    )
]


#Preview {
    OnboardingView()
}
