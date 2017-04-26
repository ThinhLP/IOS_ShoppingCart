//
//  APIConstant.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/20/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import Foundation

struct ApiConstant {
    static let googleMapAPIKey = "AIzaSyCtywRRR15kHC5A5MMxeKYIkaKriOu2jOg"
    
    static let baseURL = "http://192.168.43.118:3000/api"
    
    struct URL {
        static let login = "/login"
        static let register = "/register"
        static let listProduct = "/listProduct/"
        static let productDetail = "/productDetail"
        static let checkout = "/checkout"
    }
    
}
