//
//  FavViewController.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/03.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import PKHUD
import Firebase

class FavViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

    @IBOutlet weak var favTableView: UITableView!
    
    var titleName :String = ""
    var videoId = String()
    var imageURL = String()
    var youtubeURL = String()
    var channelTitle = String()
    var userName :String = ""
    var userID :String = ""
    
    var youtubeDataArray = [YoutubeData]()
    
    
    let favRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favTableView.allowsSelection = true
        favTableView.delegate = self
        favTableView.dataSource = self
        userID = Auth.auth().currentUser!.uid
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
                       self.favTableView.reloadData()
                       
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
            
            youtubeDataArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
        
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

