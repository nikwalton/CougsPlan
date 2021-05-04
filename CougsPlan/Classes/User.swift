//
//  User.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 4/19/21.
//

import Foundation

class User {
    var name: String
    var major: String
    var id: String?
    
    init(name: String, major: String) {
        self.name = name
        self.major = major
    }
    
    init(dict: [String: Any]) {
        self.name = dict["name"] as! String
        self.major = dict["major"] as! String
    }
    
    func toDict() -> [String: Any] {
        return ["name": name, "major": major]
    }
}
