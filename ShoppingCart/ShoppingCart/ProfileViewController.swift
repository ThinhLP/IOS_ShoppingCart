//
//  ProfileViewController.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/21/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var cartStatusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Configure navigation
    func configureNavigation() {
        self.navigationItem.title = "Profile"
    }

    // MARK: - Set info to label
    func setInfo() {
        usernameLabel.text = UserDefaults.standard.value(forKey: Constant.UserInfoKey.username) as! String?
        phoneLabel.text = "0123456789"
        genderLabel.text = "Female"
        cartStatusLabel.text = "Not payment"
    }
    
    // MARK: - Process when user click log out
    @IBAction func logOut(_ sender: UIButton) {
        // Remove user info
        Util.removeUserInfoFromUserDefault()
        // Back to login view
        _ = navigationController?.popToRootViewController(animated: false)
    }
    

}
