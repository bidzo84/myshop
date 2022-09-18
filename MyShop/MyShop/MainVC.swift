//
//  MainVC.swift
//  MyShop
//
//  Created by Bidzina Sazandrishvili on 09.09.22.
//

import UIKit
import CoreMIDI


class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var mainListView: UITableView!
    
    @IBOutlet weak var itemCountLbl: UILabel!
    @IBOutlet weak var sumOfSelectedItemPrice: UILabel!
    
    @IBOutlet weak var goToCartBtn: UIButton!
    
    
    
    var itemsList: [[ProductInfo]] = []
    
 
    
    var selectedProductList: [Int: Int] = [:]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableview()
        getItems()
        
        goToCartBtn.isEnabled = true
        
        
        
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 75))
        mainListView.register(UINib(nibName: "CustomSection", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomSection")
        mainListView.tableFooterView = footer
        
        
    }
    
    func getItems() {
        NetworkService.shared.getItems { [weak self] producData in
            var productIDs = Set<String>()
            
            for element in producData.products {
                productIDs.insert(element.category)
            }
            
            for productID in productIDs.sorted(by: { $0 < $1 } ) {
                let filtered = producData.products.filter { $0.category == productID }
                self?.itemsList.append(filtered)
            }
            
            DispatchQueue.main.async {
                self?.mainListView.reloadData()
            }
        }
    }
    
    
    func configureTableview() {
        mainListView.delegate = self
        mainListView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsList[section].count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        itemsList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = mainListView.dequeueReusableHeaderFooterView(withIdentifier: "CustomSection") as! ListSelectionView
        
        headerView.sectionTitleLabel.text = "\(itemsList[section].first!.category!)".uppercased()
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let arrayForShow = itemsList[indexPath.section]
        let currentItem = arrayForShow[indexPath.row]
        cell.productName.text = "\(currentItem.title)".capitalized
        cell.stockLbl.text = "\(currentItem.stock)"
        cell.productPriceLbl.text = "\(currentItem.price)"
        cell.productImage.load(url: URL(string: currentItem.thumbnail)!)
        
        cell.quantityClouser = { add, number in
            
            let sumOfItem = Int(self.itemCountLbl.text!)
            let sumOfPrice = Int(self.sumOfSelectedItemPrice.text!)
            
            if add {
                
                print("1")
                //self.goToCartBtn.isEnabled = true
                self.itemCountLbl.text = String((sumOfItem ?? 0) + 1)
                self.sumOfSelectedItemPrice.text = String((sumOfPrice ?? 0) + currentItem.price)
                
                
                
                if self.selectedProductList[number] != nil {
                    self.selectedProductList.updateValue(self.selectedProductList[number]! + 1, forKey: number)
                    print("2")
                    
                } else {
                    print("3")
                    
                    self.selectedProductList.updateValue(1, forKey: number)
                    
                }
                
            } else {
                
                self.itemCountLbl.text = String(sumOfItem == 0 ? 0 : sumOfItem! - 1)
                self.sumOfSelectedItemPrice.text = String((sumOfPrice ?? 0) - currentItem.price)
                print("4")
                
                
                if self.selectedProductList[number] == nil {
                    
                    self.selectedProductList.updateValue((self.selectedProductList[number] ?? 0) - 1, forKey: number)
                    
                    print("5")
                    
                    if self.selectedProductList[number] == 0 {
                        
                        self.selectedProductList.removeValue(forKey: number)
                        
                        print("6")
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
    
    
    @IBAction func goToCartBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let shopingCart = storyBoard.instantiateViewController(withIdentifier: "SelectidItemsVC") as! SelectidItemsVC
        
        
        var paymentData: [ChosenProducts] = []
        if !selectedProductList.isEmpty {
            
            for item in selectedProductList {
                for i in 0...itemsList.count - 1 {
                    
                    for j in 0...itemsList[i].count - 1 {
                        if item.key == itemsList[i][j].id {
                            paymentData.append(ChosenProducts(count: item.value, product: itemsList[i][j]))
                        }
                    }
                }
            }
        }
        
        
        navigationController?.pushViewController(shopingCart, animated: true);
    }
    
    
}



