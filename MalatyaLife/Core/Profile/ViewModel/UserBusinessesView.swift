//
//  UserBusinessesView.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 23.02.2024.
//

import SwiftUI

struct UserBusinessesView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.businesses) { business in
                    if business.isActive {
                        NavigationLink(destination: BusinessDetailView(business: business).navigationBarBackButtonHidden()) {
                            BusinessCell(business: business)
                        }
                    } else {
                        ZStack {
                            BusinessCell(business: business)
                                .opacity(0.5)
                            
                            HStack {
                                Spacer()
                                
                                Text("Aktif Değil")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.vertical,4)
                                    .padding(.horizontal)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("İşletmelerim")
        }
    }
}

#Preview {
    UserBusinessesView()
}
