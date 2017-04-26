//
//  ViewController.swift
//  EcomercyApp
//
//  Created by Thinh Le Phuc on 4/19/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTextField()
        activityIndicator.isHidden = true
        configureTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        clearStatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Configure navigation
    func configureNavigation() {
        self.navigationItem.title = "Login"
        self.navigationController?.navigationBar.barTintColor = Constant.Color.main
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    // MARK: - Configure textfield 
    func configureTextField() {
        passwordTextField.isSecureTextEntry = true
    }
    
    // MARK: - Clear status
    func clearStatus() {
        statusLabel.text = " "
    }
    
    // MARK: - Resign first responder of text field
    override func resignFirstResponderTextField() {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // MARK: - Process when click button Login
    @IBAction func login(_ sender: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text,
            !username.isEmpty && !password.isEmpty else {
            return
        }
        Util.showActivityIndicator(activityIndicator)
        ProductAPI.checkLogin(username: username, password: password) {
            result, error in
            guard let result = result, error == nil else {
                DispatchQueue.main.async {
                    Util.setStatus(for: self.statusLabel, text: error?.localizedDescription ?? "Invalid username or password", color: Constant.Color.fail)
                    Util.hiddenActivityIndicator(self.activityIndicator)
                }
                return
            }
            // Store username
            Util.storeUserInfo(username: result.username, userId: result.userId)
            // Push to list food view controller
            DispatchQueue.main.async {
                let destination = self.storyboard?.instantiateViewController(withIdentifier: Constant.Identifier.listFoodViewController)
                self.navigationController?.pushViewController(destination!, animated: true)
                Util.hiddenActivityIndicator(self.activityIndicator)
            }
        }
        
        
    }
    
    // MARK: - Process when click button Sign up
    @IBAction func signUp(_ sender: UIButton) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: Constant.Identifier.signUpViewController)
        self.navigationController?.pushViewController(destination!, animated: true)
    }
    
}

