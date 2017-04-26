//
//  File.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/20/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

struct Util {
    static func setStatus(for label: UILabel, text: String, color: UIColor) {
        label.text = text
        label.textColor = color
    }
    
    // MARK: - Set status of activity indicator
    static func showActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        activityIndicator.isHidden = false
        // Start animating for activity indicator
        activityIndicator.startAnimating()
    }
    static func hiddenActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    // Store User information
    static func storeUserInfo(username: String, userId: String) {
        UserDefaults.standard.setValue(username, forKey: Constant.UserInfoKey.username)
        UserDefaults.standard.setValue(userId, forKey: Constant.UserInfoKey.userId)
    }
    
    // MARK: - Remove user info
    static func removeUserInfoFromUserDefault() {
        UserDefaults.standard.removeObject(forKey: Constant.UserInfoKey.username)
        UserDefaults.standard.removeObject(forKey: Constant.UserInfoKey.userId)
    }
    
    
}
