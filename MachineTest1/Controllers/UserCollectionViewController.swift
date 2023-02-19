//
//  UserCollectionViewController.swift
//  MachineTest1
//
//  Created by Sejal on 11/02/23.
//

import UIKit

class UserCollectionViewController: UIViewController, UsersProtocol{
    func passData(userdata: [UsersData]) {
                userArray = userdata
        DispatchQueue.main.async {
            self.UserCollectionViewTable.reloadData()
        }
                    }
    
    var userArray: [UsersData] = []
    
    @IBOutlet weak var UserCollectionViewTable: UICollectionView!
    
    
    @IBAction func fetchDataButton(_ sender: Any) {
        let navigateToLoad = (self.storyboard?.instantiateViewController(withIdentifier: "LoadDataViewController") as? LoadDataViewController )!
        navigateToLoad.userdataProtocolReference = self
        navigationController?.pushViewController(navigateToLoad, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register XIB
        let nib = UINib(nibName: "UserCollectionViewCell", bundle: nil)
        UserCollectionViewTable.register(nib, forCellWithReuseIdentifier: "UserCollectionViewCell")
        
        UserCollectionViewTable.delegate = self
        UserCollectionViewTable.dataSource = self
    
    }
}
extension UserCollectionViewController :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        let user = userArray[indexPath.row]
        item.userNameLabel.text = user.FirstName
        item.userLastnameLabel.text = user.lastName
        item.emaiLabel.text = user.email
        return item
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: (collectionView.frame.size.width - 50) / 2, height: (collectionView.frame.size.width - 50) / 2)
    }
}



