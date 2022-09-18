//
//  File.swift
//  MyShop
//
//  Created by Bidzina Sazandrishvili on 10.09.22.
//
 
import Foundation
import UIKit


struct ProductsData: Codable {
    var products: [ProductInfo]
}

struct ProductInfo: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String!
    let thumbnail: String
}




class ChosenProducts {
    let count: Int
    let procuct: ProductInfo
    
    init(count: Int, product: ProductInfo) {
        self.count = count
        self.procuct = product
    }
}





 

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            } else {
            
            }
        }
    }
}
