//
//  ShopingCartCell.swift
//  MyShop
//
//  Created by Bidzina Sazandrishvili on 17.09.22.
//

import UIKit

class ShopingCartCell: UITableViewCell {
    
    
    @IBOutlet weak var cartItemPhoto: UIImageView!
    @IBOutlet weak var cartItemNameLabel: UILabel!
    @IBOutlet weak var cartItemCountLabel: UILabel!
    @IBOutlet weak var cartItemPrice: UILabel!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
