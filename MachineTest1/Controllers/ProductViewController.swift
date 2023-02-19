//
//  ProductViewController.swift
//  MachineTest1
//
//  Created by Sejal on 19/02/23.
//

import Foundation
import UIKit

class ProductViewController: UIViewController{
    var productsData = [Products]()
    
    
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        
       // populateProduct()
        //register XIB
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        productTableView.register(nib, forCellReuseIdentifier: "ProductTableViewCell" )
        productTableView.delegate = self
        productTableView.dataSource = self
    }
    
    @IBAction func fetchDataButton(_ sender: Any) {
        
        fetchProductDataFromApi()
        
    }
    func populateProduct(){
        productsData.append(Products.init(title: "sejal", description: "String", price: 12, rating: 10.0))
        
    }
    
    func fetchProductDataFromApi() {
        let urlString = "https://dummyjson.com/products"
        guard let url = URL(string: urlString) else {
            return
            
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            print(String(data: data!, encoding: .utf8)!)
            
            let getJSONObject = try! JSONSerialization.jsonObject(with: data!) as! [String : Any]
            
            let jsonArray = getJSONObject["products"] as! [[String : Any]]
            
            for dictionary in jsonArray {
                let productTitle = dictionary["title"] as! String
                let productDescription = dictionary["description"] as! String
                let productPrice = dictionary["price"] as! Int
                let productRating = dictionary["rating"] as! Double
                
                let newProductObject = Products(title: productTitle, description: productDescription, price: productPrice, rating:productRating)
                
                self.productsData.append(newProductObject)
                
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            }
            
        }
        dataTask.resume()
    }
}

    extension ProductViewController: UITableViewDataSource,UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            productsData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
            let product = productsData[indexPath.row]
            cell.titleLabel.text = product.title
            cell.descriptionLabel.text = product.description
            cell.ratingLabel.text = "\(product.rating)"
            cell.priceLabel.text = "\( product.price)"
            return cell
        }
        
        
    }

