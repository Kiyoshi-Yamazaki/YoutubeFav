//
//  UsersViewController.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/04.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase
import PKHUD

class UsersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var usersTableView: UITableView!
    
    var getUserDataArray = [GetUserData]()
    let userDB = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.allowsSelection = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HUD.show(.success)
        
        userDB.child("Profile").observe(.value) { (snapshot) in
                
            
                   self.getUserDataArray.removeAll()
                   
                   for child in snapshot.children{
                       
                       let childSnapshot = child as! DataSnapshot
                       let listData = GetUserData(snapshot: childSnapshot)
                       self.getUserDataArray.insert(listData, at: 0)
                       self.usersTableView.reloadData()
                       
                       
                   }
            HUD.hide()
                   
                   
               }
        
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        return getUserDataArray.count
      }
      
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 170
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let nameLabel = cell.contentView.viewWithTag(1) as! UILabel
        
        nameLabel.text = "\(getUserDataArray[indexPath.row].userName)'s list"
        nameLabel.textColor = .white
        
        return cell
      }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let listVC = storyboard?.instantiateViewController(withIdentifier: "listVC") as! UserListViewController
        
        listVC.userName = getUserDataArray[indexPath.row].userName
        listVC.userID = getUserDataArray[indexPath.row].userID
        
        navigationController?.pushViewController(listVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
