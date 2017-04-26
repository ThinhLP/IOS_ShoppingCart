//
//  Constant.swift
//  EcomercyApp
//
//  Created by Thinh Le Phuc on 4/20/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

struct Constant {
    struct Identifier {
        static let listFoodViewController = "listFoodVC"
        static let signUpViewController = "signUpVC"
        static let profileViewController = "profileVC"
        static let cartViewController = "cartVC"
        static let checkOutViewController = "checkOutVC"
        static let foodDetailViewController = "foodDetailVC"
        
        static let foodTableViewCell = "foodViewCell"
        static let cartItemTableViewCell = "cartItemCell"
    }

    struct Color {
        static let success = UIColor.green
        static let fail = UIColor.red
        static let main = UIColor(red: 211/255, green: 35/255, blue: 35/255, alpha: 1)
    }
    
    struct UserInfoKey {
        static let username = "username"
        static let userId = "userId"
        static let userDisplayName = "userDisplayName"
        static let cart = "cart"
    }
    
    struct ErrorMsg {
        static let dataNotFound = "Data not found" as? Error
        static let parseJsonError = "Error when parsing JSON" as? Error
        static let listNotFound = "List not found" as? Error
        static let statusError = "Status not found" as? Error
    }
}
