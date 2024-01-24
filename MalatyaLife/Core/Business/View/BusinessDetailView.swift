//
//  BusinessDetailView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import SwiftUI
import Kingfisher

struct BusinessDetailView: View {
    @State var business : Business
    @Environment(\.dismiss) var dismiss
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment:.leading, spacing: 0) {
                BusinessImage()
                    .overlay {
                        BackButton()
                    }
                
                HStack {
                    VStack(alignment:.leading) {
                        Text(business.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Text("\(business.district)\(districtSuffix(district: business.district)) bir \(business.category)")
                        
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                
                VStack(alignment:.leading, spacing:10) {
                    HStack {
                        HStack {
                            Text(business.workingHours)
                                .foregroundStyle(.primary)
                                .bold()
                            Text("arası açık")
                        }
                        
                        Spacer()
                        
                        Text(getOffDay())
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    
                    Divider()
                    
                    Text(business.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.top)
                    
                    Text("Adres")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.top)
                    
                    Text(business.address)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    BusinessSocialLinks()
                    
                    Spacer()
                    
                    Button {
                        guard let url = URL(string: "tel://\(business.phone)") else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        Text("Ara")
                            .font(.body)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .tint(.green)
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .padding(.top,50)
                    .padding(.bottom,20)
                }
                .padding()
            }
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    @ViewBuilder
    func BusinessImage() -> some View {
        VStack {
            if let imageUrl = business.image {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenWidth, height: 320)
            } else {
                LoadingView()
            }
        }
    }
    
    @ViewBuilder
    func BusinessSocialLinks() -> some View {
        HStack {
            HStack(spacing:20) {
                if (business.website != "") {
                    Button {
                        guard let url = URL(string: "\(business.facebook!)") else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        Image(systemName: "globe")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                
                
                if (business.facebook != "") {
                    Button {
                        guard let url = URL(string: "https://facebook.com/\(business.facebook!)") else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        Image("facebook-icon")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                
                if (business.instagram != "") {
                    Button {
                        guard let url = URL(string: "https://instagram.com/\(business.instagram!)") else { return }
                        UIApplication.shared.open(url)
                    } label: {
                        Image("instagram-icon")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                
            }
            
            Spacer()
            
//            Button {
//                
//            } label: {
//                Image(systemName: "map")
//                    .resizable()
//                    .frame(width: 24, height: 24)
//                
//                Text("Göster")
//                    .font(.subheadline)
//            }
//            .foregroundStyle(Color.brown)
            
        }
        .padding(.top,20)
    }
    
    @ViewBuilder
    func BackButton() -> some View {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let edgeInsets = scene?.windows.first?.safeAreaInsets ?? .zero
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.title3)
                        .padding()
                }
                .foregroundColor(.white)
                .background(.accent)
                .clipShape(Circle())
                
                Spacer()
            }
            .padding(.horizontal,20)
            
            Spacer()
        }
        .padding(.top, edgeInsets.top)
    }
    
    private func districtSuffix(district: String) -> String {
        let lastVowel = district.last(where: { "aeıioöuü".contains($0) }) ?? "a"
        let lastConsonant = district.last(where: { "bcçdfgğhjklmnpqrsştwxyz".contains($0) }) ?? "b"
        
        switch (lastVowel, lastConsonant) {
        case ("a", "f"), ("a", "s"), ("a", "t"), ("a", "k"), ("a", "ç"), ("a", "ş"), ("a", "h"), ("a", "p"),
            ("ı", "f"), ("ı", "s"), ("ı", "t"), ("ı", "k"), ("ı", "ç"), ("ı", "ş"), ("ı", "h"), ("ı", "p"):
            return "ta"
        case ("e", "f"), ("e", "s"), ("e", "t"), ("e", "k"), ("e", "ç"), ("e", "ş"), ("e", "h"), ("e", "p"),
            ("i", "f"), ("i", "s"), ("i", "t"), ("i", "k"), ("i", "ç"), ("i", "ş"), ("i", "h"), ("i", "p"):
            return "te"
        case (_, "f"), (_, "s"), (_, "t"), (_, "k"), (_, "ç"), (_, "ş"), (_, "h"), (_, "p"):
            return "ta"
        default:
            return "da"
        }
    }
    
    private func getOffDay() -> String {
        if business.offDay == Business.WeekDay.noOffDay.rawValue {
            return ""
        } else {
            return "\(business.offDay) günü kapalı"
        }
    }
}

#Preview {
    BusinessDetailView(business: BusinessMockData.sampleBusiness01)
}



