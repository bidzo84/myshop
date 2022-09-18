//
//  NetworkService.swift
//  MyShop
//
//  Created by Bidzina Sazandrishvili on 12.09.22.
//


import Foundation

class NetworkService {
    
    static var shared = NetworkService()
    
    
 
    func getItems(completion: @escaping (ProductsData)->()) {
        let url = URL(string: "https://dummyjson.com/products")!
        let urlReq = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlReq) { data, response, error in
            print(Thread.current.isMainThread)
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("no response")
                return
            }
            
            guard (200...300).contains(response.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            do {
                let itemList = try JSONDecoder().decode(ProductsData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(itemList)
                }
            } catch {
                print("error")
            }
        } .resume()
    }
}






//
//
//
//import Foundation
//
//class NetworkService {
//    
//static var shared = NetworkService()
//    
//    func getItems(completion: @escaping (ProductModel) -> ()) {
//    
//       let url = URL(string: "https://dummyjson.com/products")!
//       let urlReq = URLRequest(url: url)
//       
//       URLSession.shared.dataTask(with: urlReq) { data, response, error in
//           print(Thread.current.isMainThread)
//           guard error == nil else {
//               print(error!.localizedDescription)
//               return
//           }
//           
//           guard let response = response as? HTTPURLResponse else {
//               print("no response")
//               return
//           }
//           
//           guard (200...300).contains(response.statusCode) else {
//               return
//           }
//           
//           guard let data = data else {
//               return
//           }
//           
//           do {
//               
//               let productResponseData = try JSONDecoder().decode(ProductModel.self, from: data)
//                
//               
//               DispatchQueue.main.async {
//                   completion(productResponseData)
//               }
//           } catch {
//               print(error)
//           }
//       }.resume()
//
//   }
//}
