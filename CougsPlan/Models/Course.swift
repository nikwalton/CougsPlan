//
//  Course.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 5/4/21.
//

import Foundation

struct Course: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var time: String
    var days: String
    var location: String
}
