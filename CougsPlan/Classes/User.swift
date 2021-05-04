//
//  User.swift
//  CougsPlan
//
//  Created by Nikolaus Walton on 4/19/21.
//

import Foundation


class User: Codable {
    var name: String
    var major: String
    var uid: String
    
    init(name: String, major: String, uid: String) {
        self.name = name
        self.major = major
        self.uid = uid
    }
    
    init(dict: [String: Any]) {
        self.name = dict["name"] as! String
        self.major = dict["major"] as! String
        self.uid = dict["uid"] as! String
    }
    
    func toDict() -> [String: Any] {
        return ["name": name, "major": major]
    }
}
