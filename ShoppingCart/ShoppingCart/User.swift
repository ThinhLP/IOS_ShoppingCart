//
//  User.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/20/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import Foundation

class User {
    let username: String
    let userId: String
    let userDisplayName: String?
    
    init(dictionary: [String: String]) {
        username = dictionary["username"]!
        userId = dictionary["userId"]!
        userDisplayName = dictionary["userDisplayName"]
    }
    
    class func getUserInfo(dictionary: [String: String]) -> User {
        return User(dictionary: dictionary)
    }
}
