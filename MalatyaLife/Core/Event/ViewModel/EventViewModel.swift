//
//  EventViewModel.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 14.02.2024.
//

import Firebase
import FirebaseFirestoreSwift

class EventViewModel: ObservableObject {
    @Published var events : [Event] = []
    @Published var isLoading : Bool = false
    
    init() {
        Task {
            await fetchEvents()
        }
    }
    
    let db = Firestore.firestore()
    
    @MainActor
    func fetchEvents() {
        isLoading = true
        db.collection("events")
            .order(by: "date",descending: false)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                let events = documents.compactMap { queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: Event.self)
                }
                self.events = events
                self.isLoading = false
            }
    }
    
    func getEventDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "tr_TR") // Türkçe tarih formatı için
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else {
            return "Geçersiz tarih formatı"
        }

        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }

}
