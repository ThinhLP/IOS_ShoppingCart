//
//  CartItem.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/24/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import Foundation

class CartItem {
    static let cartKey = Constant.UserInfoKey.cart + "\(UserDefaults.standard.string(forKey: Constant.UserInfoKey.userId) ?? "")"
    let item: Food
    let quantity: Int
 
    init(item: Food, quantity: Int) {
        self.item = item
        self.quantity = quantity
    }
    
    // MARK: - Converit list cartItem to JSON
    class func convertToJson(from items: [CartItem]) -> String {
        var result: [[String: Int]] = []
        for item in items {
            var product: [String: Int] = [:]
            let productId = item.item.productId
            product["productId"] = productId
            product["count"] = item.quantity
            result.append(product)
        }
        var resultStr: String = "\(result)"
        resultStr = resultStr.replacingOccurrences(of: "[", with: "{").replacingOccurrences(of: "]", with: "}")
        // Remove { and } at the begin and end of string
        let start = resultStr.index(after: resultStr.startIndex)
        let end = resultStr.index(before: resultStr.endIndex)
        resultStr = resultStr.substring(with: start..<end)
        // Add [ and ] to the begin and end of string
        resultStr = "[" + resultStr + "]"
        return resultStr
    }
    
    // MARK: - Add item to cart
    class func addToCart(productId: Int) {
        // Get current cart from UserDefault
        var cart = UserDefaults.standard.dictionary(forKey: cartKey) as? [String: Int]
        // If cart hasn't existed, create new cart
        if (cart == nil) {
            cart = [String: Int]()
        }
        // By default, item hasn't exist in cart and quantity = 1
        var quantity = 1
        // If item is exist in cart, then increase quantity
        if let item = cart!["\(productId)"] {
            quantity = item + 1
        }
        cart!["\(productId)"] = quantity
        // Stored new cart in userdefault
        UserDefaults.standard.set(cart, forKey: cartKey)
    }
    
    // MARK: - Remove item from cart
    class func removeItemFromCart(productId: Int) {
        guard var cart = UserDefaults.standard.dictionary(forKey: cartKey) as? [String: Int] else {
            return
        }
        cart.removeValue(forKey: "\(productId)")
        UserDefaults.standard.set(cart, forKey: cartKey)
    }
    
    // MARK: - Update quantity of item in cart
    class func updateCart(productId: Int, quantity: Int) {
        guard var cart = UserDefaults.standard.dictionary(forKey: cartKey) as? [String: Int] else {
            return
        }
        cart["\(productId)"] = quantity
        UserDefaults.standard.set(cart, forKey: cartKey)
    }
    
    // MARK: - Remove all items in cart
    class func clearCart() {
        UserDefaults.standard.set(nil, forKey: cartKey)
    }
    
    // MARK: - Get current cart
    class func getCurrentCart() -> [String: Int]? {
        return UserDefaults.standard.dictionary(forKey: cartKey) as? [String: Int]
    }
}
