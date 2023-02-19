//
//  LoadDataViewController.swift
//  MachineTest1
//
//  Created by Sejal on 11/02/23.
//

import UIKit

class LoadDataViewController: UIViewController {
    
    var userData = [UsersData]()
    var userdataProtocolReference :UsersProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func loadButton(_ sender: Any) {
    fetchApi()
        
    }
    
    func fetchApi() {
        
        let urlString = "https://reqres.in/api/users?page=2"
        guard let url = URL(string: urlString) else {
            return
            
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            print(String(data: data!, encoding: .utf8)!)
            
            let getJSONObject = try! JSONSerialization.jsonObject(with: data!) as! [String : Any]
            
            let jsonArray = getJSONObject["data"] as! [[String : Any]]
            for dictionary in jsonArray {
                
                let userFirstName = dictionary["first_name"] as! String
                let userLastName = dictionary["last_name"] as! String
                let userEmail = dictionary["email"] as! String
                let userAvtar = dictionary["avatar"] as! String
        
                let newUserObject = UsersData(FirstName: userFirstName, lastName: userLastName, email: userEmail, avatar: userAvtar)
                
                self.userData.append(newUserObject)
                self.userdataProtocolReference?.passData(userdata: self.userData)
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
            }
        dataTask.resume()

            
        }
    }

/*
 let getJSONObject = try! JSONSerialization.jsonObject(with: response!) as! [String : Any]
 
 let jsonArray2 = getJSONObject["articles"] as! [[String : Any]]
 for dictionary2 in jsonArray2 {
    let auther = dictonary2["author"] as! String
    let sourse = dictonary2["source"] as! [String : Any]
    let id = sourrse["id"] as! String
 }
 */

/*
 "articles": [
    {
      "source": {
        "id": "cnn",
        "name": "CNN"
      },
 */
