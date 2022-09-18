//
//  SelectidItemsVC.swift
//  MyShop
//
//  Created by Bidzina Sazandrishvili on 15.09.22.
//

import UIKit

class SelectidItemsVC:  UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var cartTableView: UITableView!
    
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var feeLbl: UILabel!
    @IBOutlet weak var diliveryLbl: UILabel!
    @IBOutlet weak var sumLbl: UILabel!
    
    var deliveryPrice = 50
    
   var productInBasket: [[ProductInfo]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
    }
    
    
    func configurationCartVC() {
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productInBasket.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopingCartCell", for: indexPath) as! ShopingCartCell

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           150
       }

    
    
}
