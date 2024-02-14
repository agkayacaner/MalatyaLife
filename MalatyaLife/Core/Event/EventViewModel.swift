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
            .order(by: "timestamp",descending: true)
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
    
    func getEventDate(event: Event) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: event.timestamp.dateValue())
    }
}
