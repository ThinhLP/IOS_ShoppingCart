//
//  CheckOutViewController.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/24/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class CheckOutViewController: UIViewController {
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var cartItem: [CartItem]!
    var total: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        activityIndicator.isHidden = true
        configureTapGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Configure navigation
    func configureNavigation() {
        self.navigationItem.title = "Check out"
    }
    
    // Process when click Payment button
    @IBAction func paymentAction(_ sender: UIButton) {
        // Valid input
        guard let cardNumber = cardNumberTextField.text, let expNumber = expTextField.text, let cvv = cvvTextField.text,
            !cardNumber.isEmpty && !expNumber.isEmpty && !cvv.isEmpty else {
                return
        }
        processForPayment()
    }
    
    // MARK: - Resign first responder of text field
    override func resignFirstResponderTextField() {
        cardNumberTextField.resignFirstResponder()
        expTextField.resignFirstResponder()
        cvvTextField.resignFirstResponder()
    }
    
    // MARK: - Process for payment
    func processForPayment() {
        // Show activiy indicator
        Util.showActivityIndicator(activityIndicator)
        // Process for Payment
        let userId = UserDefaults.standard.string(forKey: Constant.UserInfoKey.userId)
        ProductAPI.checkout(list: cartItem, userId: userId!, total: total) {result, error in
            var msg = ""
            guard let status = result, error == nil else {
                print(error?.localizedDescription ?? "")
                // Hidden activity indicator when error occurs
                DispatchQueue.main.async {
                    Util.hiddenActivityIndicator(self.activityIndicator)
                }
                return
            }
            // Set payment's status
            if status == 1 {
                msg = "Payment successfully!"
            } else {
                msg = "Payment failed!"
            }
            DispatchQueue.main.async {
                // Hidden activity indicator when process successfully
                Util.hiddenActivityIndicator(self.activityIndicator)
                // Configure alert to show message
                let alertController = UIAlertController(title: "Message", message: msg, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                    // Clear cart
                    CartItem.clearCart()
                    // Back to Cart View controller
                    _ = self.navigationController?.popViewController(animated: true)
        
                }))
                // Show alert
                self.present(alertController, animated: true, completion: nil)
            }
        }

    }

}
