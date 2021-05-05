//
//  CourseRepository.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 5/4/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class CourseRepository: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var courses = [Course]()
    
    func loadData(){
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { (querySnap, err) in
            if let snapshot = querySnap {
                self.courses = snapshot.documents.compactMap { document in
                   try? document.data(as: Course.self)
                   
                }
            }
        }
    }
}
