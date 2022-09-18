//
//  CustomCell.swift
//  MyShop
//
//  Created by Bidzina Sazandrishvili on 10.09.22.
//

import UIKit
 
class CustomCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var stockLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
 
    @IBOutlet weak var itemCounterLbl: UILabel!
    @IBOutlet weak var cellBg: UIView!
    
    
    
    var quantityClouser: ((Bool, Int) -> ())!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
     
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func itemQuantityPlus(_ sender: Any) {
        
        let cellBorderColor = UIColor(named: "MyAppearance")
        cellBg.layer.borderColor = cellBorderColor?.cgColor
        cellBg.layer.borderWidth = 3
        layer.masksToBounds = false
        clipsToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10.0
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        let numerProduct = Int(itemCounterLbl.text!)!
        
        itemCounterLbl.text = String(numerProduct + 1)
        quantityClouser(true, Int(itemCounterLbl.text!)!)
    }
    
    
 
    @IBAction func itemQuantityMinus(_ sender: Any) {
 
        let numerProduct = Int(itemCounterLbl.text!)!
        let push = (numerProduct == 0 ? "0" : String(numerProduct - 1))
        itemCounterLbl.text = push
        if numerProduct > 0 {
            quantityClouser(false, Int(itemCounterLbl.text!)!)
        }
        if numerProduct < 2 {
            let cellBorderColor = UIColor(named: "MyAppearance")
            cellBg.layer.borderColor = cellBorderColor?.cgColor
            cellBg.layer.borderWidth = 0
            layer.masksToBounds = false
            clipsToBounds = false
            layer.shadowColor = UIColor.black.withAlphaComponent(0).cgColor
            layer.shadowOpacity = 0
            layer.shadowOffset = CGSize.zero
            layer.shadowRadius = 0
            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            layer.shouldRasterize = false
            layer.rasterizationScale = UIScreen.main.scale
        }
        
    }
 
}

