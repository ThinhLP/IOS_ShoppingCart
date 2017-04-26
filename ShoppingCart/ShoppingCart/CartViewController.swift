//
//  CartViewController.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/24/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    var foodList: [Food] = []
    var cartItemList: [CartItem] = []
    var totalPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Configure table view
    func configureTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        cartTableView.dataSource = self
        cartTableView.delegate = self
    }
    
    // MARK: - Configure navtigation
    func configureNavigation() {
        self.navigationItem.title = "Your cart"
    }
    
    // MARK: - Show total and quantity
    func showTotalAndQuantity(total: Double) {
        totalLabel.text = "Total: $\(total)"
        self.navigationItem.title = "Your cart(\(cartItemList.count))"
    }
    
    // MARK: - Load data to show on table
    func loadData() {
        
        // Reset data
      
        cartItemList = []
        totalPrice = 0.0
        showTotalAndQuantity(total: 0)
        
        guard let cart = CartItem.getCurrentCart() else {
            cartTableView.reloadData()
            return
        }

        for (strId, quantity) in cart {
            if let id = Int(strId), let food = getFood(from: id) {
                let item = CartItem(item: food, quantity: quantity)
                cartItemList.append(item)
                totalPrice += food.price * Double(quantity)
            }
        }
        showTotalAndQuantity(total: totalPrice)
        cartTableView.reloadData()
    }
    
    // MARK: - Get Food from ID 
    func getFood(from id: Int) -> Food? {
        if foodList.isEmpty {
            return nil
        }
        for food in foodList {
            if food.productId == id {
                return food
            }
        }
        return nil
    }

    // MARK: - Clear cart from user default and reload data table
    func clearCartAndReloadData() {
        CartItem.clearCart()
        loadData()
    }
    
    // MARK: - Process when click Clear cart
    @IBAction func clearCart(_ sender: UIButton) {
        // Show alert to confirm clear cart
        let alertController = UIAlertController(title: "Confirm", message: "Would you want to clear your cart?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            self.clearCartAndReloadData()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Process when click check out
    @IBAction func checkOut(_ sender: UIButton) {
        if cartItemList.isEmpty {
            let alertController = UIAlertController(title: "Message", message: "Your cart is empty!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let destination = self.storyboard?.instantiateViewController(withIdentifier: Constant.Identifier.checkOutViewController) as! CheckOutViewController
        destination.total = totalPrice
        destination.cartItem = cartItemList
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

// MARK: - Process for TableViewDataSource
extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.cartItemTableViewCell, for: indexPath) as! CartItemTableViewCell
        if cartItemList.isEmpty {
            return cell
        }
        let item = cartItemList[indexPath.row]
        cell.delegate = self
        cell.dataSource = item
        return cell
    }
    
}

// MARK: - Process for TableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Quantity?", message: "Input quantity: ", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            if let field = alertController.textFields?[0].text, let quantity = Int(field), quantity > 0 {
                CartItem.updateCart(productId: self.cartItemList[indexPath.row].item.productId, quantity: quantity)
                // Reload data
                self.loadData()
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addTextField { (textField) in
            textField.placeholder = "Input quantity"
        }
        self.present(alertController, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK:- Process for CartItemTableViewCell Delegate
extension CartViewController: CartItemTableViewCellDelegate {
    func removeItemFromCart(productId: Int) {
        // Alert to confirm remove item
        let alertController = UIAlertController(title: "Confirm", message: "Would you want to remove this item?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            CartItem.removeItemFromCart(productId: productId)
            // Reload data
            self.loadData()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
      
    }
}

