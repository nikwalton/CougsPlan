//
//  Course.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 5/4/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Course: Identifiable{
    //when we map a document to this, id = document id in firestore
    var id: String? = UUID().uuidString
    var name: String
    var time: String
    var days: String
    var location: String
}
