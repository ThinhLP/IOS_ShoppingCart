//
//  FoodDetailViewController.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/25/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit
import GoogleMaps

class FoodDetailViewController: UIViewController {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mapView: GMSMapView!
    
    var dataSource: Food?

    var productID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showData() {
        guard let food = dataSource else {
            return
        }
        if let data = food.imageData, let restaurant = food.restaurantName, let rating = food.rating, let url = food.urlrelate {
            foodImageView.image = UIImage(data: data)
            foodNameLabel.text = "\(food.productName)"
            restaurantLabel.text = "Restaurant: \(restaurant)"
            addressLabel.text = "Address: \(food.addressName)"
            ratingLabel.text = "Rating: \(rating)"
            urlLabel.text = "URL: \(url)"
        }
    }

    
    
    // MARK: - Load data from ID
    func loadDataFromAPI() {
        // Show activity indicator and hide container view when loading data
        Util.showActivityIndicator(activityIndicator)
        containerView.isHidden = true
        // Get data
        ProductAPI.getProductDetail(by: productID) {result, error in
            guard let food = result, error == nil else {
                print(error?.localizedDescription ?? "Food is nil")
                DispatchQueue.main.async {
                    Util.hiddenActivityIndicator(self.activityIndicator)
                    self.containerView.isHidden = false
                }
                return
            }
            self.dataSource = food
            DispatchQueue.main.async {
                self.showData()
                self.setUpGoogleMap()
                Util.hiddenActivityIndicator(self.activityIndicator)
                self.containerView.isHidden = false
            }
        }
    }
    
    func setUpGoogleMap() {
        guard let food = dataSource else {
            return
        }
        let position = CLLocationCoordinate2D(latitude: food.latitude! as CLLocationDegrees, longitude: food.longitude! as CLLocationDegrees)
        let camera = GMSCameraPosition.camera(withTarget: position, zoom: 15.0)
        let marker = GMSMarker(position: position)
        marker.map = mapView
        mapView.camera = camera
        
    }
    
    // MARK: - Process when click Add to cart
    @IBAction func addToCart(_ sender: UIButton) {
        guard let food = dataSource else {
            return
        }

        CartItem.addToCart(productId: food.productId)
        let alertController = UIAlertController(title: "Message", message: "Add to cart successfully", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }


}
