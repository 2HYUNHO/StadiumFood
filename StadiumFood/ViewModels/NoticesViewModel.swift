//
//  NoticesViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 7/14/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class NoticesViewModel: ObservableObject {
    @Published var notices: [Notice] = []
    
    func fetchNotices() {
        Firestore.firestore().collection("notices").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching stadiums: \(error.localizedDescription)")
            } else if let snapshot = snapshot {
                self.notices = snapshot.documents.compactMap { document -> Notice? in
                    let id = document.documentID
                    let data = document.data()
                    let title = data["title"] as? String ?? ""
                    let timestamp = data["date"] as? Timestamp ?? Timestamp(date: Date())
                    let date = timestamp.dateValue()
                    let content = data["content"] as? String ?? ""
                    
                    return Notice(id: id, title: title, date: date, content: content)
                }
            }
        }
    }
}
