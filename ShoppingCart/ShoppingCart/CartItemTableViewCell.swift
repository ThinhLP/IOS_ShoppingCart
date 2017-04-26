//
//  CartItemTableViewCell.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/24/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

protocol CartItemTableViewCellDelegate: class {
    func removeItemFromCart(productId: Int)
}

class CartItemTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    weak var delegate: CartItemTableViewCellDelegate?
    
    var dataSource: CartItem? {
        didSet {
            guard let cartItem = dataSource else {
                return
            }
            nameLabel.text = cartItem.item.productName
            quantityLabel.text = "Quantity: \(cartItem.quantity)"
            priceLabel.text = "$ \(cartItem.item.price)"
            if let data = cartItem.item.imageData {
                itemImageView.image = UIImage(data: data)
            }      
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func removeItem(_ sender: UIButton) {
        guard let cartItem = dataSource, let delegate = self.delegate else {
            return
        }
        delegate.removeItemFromCart(productId: cartItem.item.productId)
    }
}
