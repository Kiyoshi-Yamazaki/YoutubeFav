//
//  UserListViewController.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/04.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

class UserListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var userName:String = ""
    var userID :String = ""
    
    var titleName :String = ""
    var videoId = String()
    var imageURL = String()
    var youtubeURL = String()
    var channelTitle = String()
    
    
    var youtubeDataArray = [YoutubeData]()
    
    
    let favRef = Database.database().reference()
    
    
    @IBOutlet weak var listTableView: UITableView!
    
       override func viewDidLoad() {
           super.viewDidLoad()

           listTableView.allowsSelection = true
           listTableView.delegate = self
           listTableView.dataSource = self
           
           // Do any additional setup after loading the view.
       }
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           HUD.show(.progress)
                  
                  favRef.child("users").child(userID).observe(.value){
                      (snapshot) in
                      
                      self.youtubeDataArray.removeAll()
                      
                      for child in snapshot.children{
                          
                          let childSnapshot = child as! DataSnapshot
                          let youtubeData = YoutubeData(snapshot: childSnapshot)
                          self.youtubeDataArray.insert(youtubeData, at: 0)
                          self.listTableView.reloadData()
                          
                      }
                      
                      HUD.hide()
                  }
           
           
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              
           return youtubeDataArray.count
           
       }
       func numberOfSections(in tableView: UITableView) -> Int {
           
           return 1
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           return 170
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           
           let youtubeDataModel = youtubeDataArray[indexPath.row]
           
           let channelImageView = cell.viewWithTag(1) as! UIImageView
           let channelLabel = cell.viewWithTag(2) as! UILabel
           let titleLabel = cell.viewWithTag(3) as! UILabel
           
           channelLabel.text = youtubeDataModel.channelTitle
           titleLabel.text! = youtubeDataModel.title
           channelImageView.sd_setImage(with: URL(string: youtubeDataModel.imageURLString), completed: nil)
           
           return cell
              
          }
          
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           let webVC = WebViewController()
           webVC.youtubeURL = youtubeDataArray[indexPath.row].youtubeURL
           present(webVC, animated: true, completion: nil)
           
           
       }
       

}
