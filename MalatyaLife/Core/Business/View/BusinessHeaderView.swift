//
//  HeaderView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 28.01.2024.
//

import SwiftUI
import Kingfisher

struct BusinessHeaderView: View {
    @Environment(\.dismiss) var dismiss
    var business: Business
    
    init(business: Business) {
        self.business = business
    }
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        
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
        .overlay {
            HeaderActions()
        }
        
    }
    
    @ViewBuilder
    func HeaderActions() -> some View {
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
                .foregroundColor(.primary)
                .background(.regularMaterial)
                .clipShape(Circle())
                
                Spacer()
            }
            .padding(.horizontal,20)
            
            Spacer()
        }
        .padding(.top, edgeInsets.top)
    }
}

#Preview {
    BusinessHeaderView(business: BusinessMockData.sampleBusiness01)
}
