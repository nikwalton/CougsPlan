//
//  CourseViewModel.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 5/4/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class CourseViewModel: ObservableObject {
    @Published var courses = [Course]()
    private var db = Firestore.firestore()
    
    func fetch() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        db.collection("users").document(uid).collection("courses").addSnapshotListener { (querySnapshot, err) in
            guard let docs = querySnapshot?.documents else {return}
            self.courses = docs.compactMap { docSnapshot -> Course? in
                return try? docSnapshot.data(as: Course.self)
            }
        
        }
    }
}
