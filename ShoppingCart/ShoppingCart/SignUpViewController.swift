//
//  SignOutViewController.swift
//  EcomercyApp
//
//  Created by Thinh Le Phuc on 4/20/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var statusUsernameLabel: UILabel!
    @IBOutlet weak var statusPasswordLabel: UILabel!
    @IBOutlet weak var statusConfirmLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let nameLabel = ["username", "password", "confirm password"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureNavigation()
        activityIndicator.isHidden = true
        configureTapGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Configure text field
    func configureTextField() {
        // Configure for password textfield
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        // Textfield Delegate
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        usernameTextField.delegate = self
        // Add target for text field
        usernameTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
        // Add tag for text field
        usernameTextField.tag = 0
        passwordTextField.tag = 1
        confirmPasswordTextField.tag = 2
    }
    
    // MARK: Configure navigation
    func configureNavigation() {
        self.navigationItem.title = "Sign up"
    }
    
    // MARK: - Resign first responder of text field
    override func resignFirstResponderTextField() {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }

    
    // MARK: Set status for text field
    func setStatusForTextField(with tag: Int, content: String, color: UIColor) {
        let statusLabel: UILabel
        switch tag {
        case 0:
            statusLabel = statusUsernameLabel
        case 1:
            statusLabel = statusPasswordLabel
        default:
            statusLabel = statusConfirmLabel
        }
        statusLabel.textColor = color
        statusLabel.text = content
    }
    
    // MARK: Process when text changed
    func textDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        var content: String
        let color: UIColor
        let tag = textField.tag
        
        // Check input
        if text.isEmpty {
            content = "Invalid \(nameLabel[tag])"
            color = Constant.Color.fail
        } else {
            content = " "
            color = Constant.Color.fail
            // Process for confirm password
            if let password = passwordTextField.text, tag == 2 && password != text {
                content = "Confirm password is not matched"
            }
            
        }
        setStatusForTextField(with: tag, content: content, color: color)
    }
    
    
    // MARK: Process when user click Sign up button
    @IBAction func signUp(_ sender: UIButton) {
        // Validate input
        guard let username = usernameTextField.text, !username.isEmpty else {
            setStatusForTextField(with: 0, content: "Username is empty", color: Constant.Color.fail)
            return
        }
        guard let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text, !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword else {
            setStatusForTextField(with: 2, content: "Confirm password is not matched", color: Constant.Color.fail)
            return
        }
        // Process when input is valid
        Util.showActivityIndicator(activityIndicator)
        ProductAPI.register(username: username) { result, error in
            guard let status = result, error == nil else {
                print(error?.localizedDescription ?? "")
                DispatchQueue.main.async {
                    Util.hiddenActivityIndicator(self.activityIndicator)
                }
                return
            }
            // Register successfully
            if status == 1 {
                DispatchQueue.main.async {
                    Util.hiddenActivityIndicator(self.activityIndicator)
                    _ = self.navigationController?.popViewController(animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.setStatusForTextField(with: 0, content: "Username has already existed", color: Constant.Color.fail)
                    Util.hiddenActivityIndicator(self.activityIndicator)
                }
            }
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


