//
//  Food.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/20/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import Foundation

class Food {
    let productId: Int
    let addressName: String
    let productName: String
    let productImageURL: String?
    let imageData: Data?
    let price: Double
    let districtName: String?
    let latitude: Double?
    let longitude: Double?
    let rating: String?
    let restaurantName: String?
    let urlrelate: String?
    
    init(dictionary: [String: Any]) {
        productId = dictionary["productId"] as! Int
        addressName = dictionary["addressName"]  as! String
        productName = dictionary["productName"] as! String
        productImageURL = dictionary["productImageUrl"] as? String
        let url = URL(string: productImageURL!)
        do {
            imageData = try Data(contentsOf: url!)
        } catch {
            imageData = nil
        }
        price = 1.0
        districtName = dictionary["districtName"] as? String
        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        rating = dictionary["rating"] as? String
        restaurantName = dictionary["restaurantName"] as? String
        urlrelate = dictionary["urlrelate"] as? String
    }
    
    class func getFoodList(array: [[String: Any]]) -> [Food] {
        var foodList = [Food]()
        for dictionary in array {
            let food = Food(dictionary: dictionary)
            foodList.append(food)
        }
        return foodList
    }
    
}
