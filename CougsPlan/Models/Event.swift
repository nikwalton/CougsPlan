//
//  Event.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 5/5/21.
//

import Foundation

struct Event: Identifiable {
    var id: String? = UUID().uuidString
    var name: String
    var time: String
    var date: String
    var location: String
}
