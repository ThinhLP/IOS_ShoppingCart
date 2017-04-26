//
//  ProductAPI.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/20/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import Foundation

typealias ApiFoodListCallback = ([Food]?, Error?) -> Void
typealias ApiLoginCallback = (User?, Error?) -> Void
typealias ApiRegisterCallback = (Int?, Error?) -> Void
typealias ApiGetDetailCallBack = (Food?, Error?) -> Void

class ProductAPI {
    // MARK: - Check login
    class func checkLogin(username: String, password: String, completion: @escaping ApiLoginCallback) {
        let session = URLSession(configuration: .default)
        let requestURL = URL(string: ApiConstant.baseURL + ApiConstant.URL.login)
        var request = URLRequest(url: requestURL!)
        let params = "username=\(username)&password=\(password)"
        request.httpBody = params.data(using: .utf8)
        request.httpMethod = "POST"
        let task = session.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error ?? Constant.ErrorMsg.dataNotFound)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                if let result = json["user"] as? [String: String] {
                    completion(User.getUserInfo(dictionary: result), nil)
                } else {
                    completion(nil, nil)
                }
                
            } catch {
                completion(nil, Constant.ErrorMsg.parseJsonError)
            }
        }
        task.resume()
    }
    
    // MARK: - Get food list from API
    class func getFoodList(completion: @escaping ApiFoodListCallback) {
        var request = URLRequest(url: URL(string: ApiConstant.baseURL + ApiConstant.URL.listProduct)!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error ?? Constant.ErrorMsg.dataNotFound)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if let result = json["products"] as? [[String: Any]] {
                    completion(Food.getFoodList(array: result), nil)
                } else {
                    completion(nil, Constant.ErrorMsg.listNotFound)
                }
            } catch {
                completion(nil, Constant.ErrorMsg.parseJsonError)
            }

        }.resume()
    }
    
    
    // MARK: - Register new user
    class func register(username: String, completion: @escaping ApiRegisterCallback) {
        var request = URLRequest(url: URL(string: ApiConstant.baseURL + ApiConstant.URL.register)!)
        let params = "username=\(username)"
        request.httpMethod = "POST"
        request.httpBody = params.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error ?? "Data not found" as? Error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if let result = json["statusCode"] as? Int {
                    completion(result, nil)
                } else {
                    completion(nil, Constant.ErrorMsg.statusError)
                }
            } catch {
                completion(nil, Constant.ErrorMsg.parseJsonError)
            }
        }.resume()
    }
    
    class func createParamsForCheckout(list: [CartItem], userId: String, total: Double) -> String {
        var params = ""
        let date = Date()
        params += "receiptName=Receipt \(date)"
        params += "&datetime=\(date)"
        params += "&product=\(CartItem.convertToJson(from: list))"
        params += "&priceTotal=\(total)"
        params += "&method=\(1)"
        params += "&currencyUnit=\(1)"
        params += "&userId=\(userId)"
        return params
    }
    
    // MARK: - Checkout
    class func checkout(list: [CartItem], userId: String, total: Double, completion: @escaping ApiRegisterCallback) {
        var request = URLRequest(url: URL(string: ApiConstant.baseURL + ApiConstant.URL.checkout)!)
        let params = createParamsForCheckout(list: list, userId: userId, total: total)
        request.httpMethod = "POST"
        request.httpBody = params.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error ?? "Data not found" as? Error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if let result = json["statusCode"] as? Int {
                    completion(result, nil)
                } else {
                    completion(nil, Constant.ErrorMsg.statusError)
                }
            } catch {
                completion(nil, Constant.ErrorMsg.parseJsonError)
            }
        }.resume()
    }
    
    // MARK: - Get product detail by its id
    
    class func getProductDetail(by productId: Int, completion: @escaping ApiGetDetailCallBack) {
        var request = URLRequest(url: URL(string: ApiConstant.baseURL + ApiConstant.URL.productDetail)!)
        let params = "productId=\(productId)"
        request.httpBody = params.data(using: .utf8)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error ?? Constant.ErrorMsg.dataNotFound)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                completion(Food(dictionary: json), nil)
            } catch {
                completion(nil, Constant.ErrorMsg.parseJsonError)
            }
        }.resume()
    }
}
