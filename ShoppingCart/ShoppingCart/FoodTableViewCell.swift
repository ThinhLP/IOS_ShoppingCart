//
//  FoodTableViewCell.swift
//  ShoppingCart
//
//  Created by Thinh Le Phuc on 4/20/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

protocol FoodTableViewCellDelegate: class {
    func addToCart(productId: Int)
}

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    weak var delegate: FoodTableViewCellDelegate?
    
    var dataSource: Food? {
        didSet {
            guard let food = dataSource else {
                return 
            }
            foodNameLabel.text = food.productName
            descriptionLabel.text = food.addressName
            if let data = food.imageData {
                foodImageView.image = UIImage(data: data)
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
    
    // MARK: - Process when click add to cart
    @IBAction func addToCartAction(_ sender: UIButton) {
        guard let food = dataSource else {
            return
        }
        delegate?.addToCart(productId: food.productId)
    }


}
