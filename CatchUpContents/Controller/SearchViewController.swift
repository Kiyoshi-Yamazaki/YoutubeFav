//
//  SearchViewController.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/01.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import Alamofire
import SwiftyJSON
import SDWebImage
import PKHUD

class SearchViewController: UIViewController,UITextFieldDelegate {

    var userPass :String = ""
    var userID : String = ""
    var userName : String = ""
    var autoID : String = ""
    var user = Auth.auth().currentUser
    
    var titleArrey = [String]()
    var videoIdArrey = [String]()
    var imageURLArrey = [String]()
    var youtubeURLArrey = [String]()
    var channelTitleArrey = [String]()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        
        if user != nil {
            
            if user!.isAnonymous {
                
                userName = UserDefaults.standard.object(forKey: "userName") as! String
                
                
            }else{
                userName = (user?.displayName)!
            }
            userID = user!.uid
            
        }else{
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let regVC = storyBoard.instantiateViewController(withIdentifier: "register")
            regVC.modalPresentationStyle = .fullScreen
            present(regVC, animated: true, completion: nil)
            
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func searchAction(_ sender: Any) {
        
        if searchTextField.text != ""{
            
             startParse(key: searchTextField.text!)
            
        }else{
            
            let alert = Alert()
            alert.showAlert(title: "再入力", message: "検索ワードを入力してください", viewController: self)
            
        }
        
        
    }
    
    
    func startParse(key:String){
        
        HUD.show(.progress)
            
            titleArrey = [String]()
            videoIdArrey = [String]()
            imageURLArrey = [String]()
            youtubeURLArrey = [String]()
            channelTitleArrey = [String]()
            
            let urlString = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyCIRFIVkrWdxEmbrjf6J1W2B_OahFHOZ8s&q=\(key)&part=snippet&maxResults=40&order=date"
            
            let encordUrlString :String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            AF.request(encordUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
                
                switch response.result{
                    
                case .success:
                    
                    let json:JSON = JSON(response.data as Any)
                    
                    for i in 0...19{
                        let title :String
                        let imageURLString :String
                        let youtubeURL:String
                        let channelTitle :String
                        let videoId = json["items"][i]["id"]["videoId"].string
                            
                        if let videoID = videoId {
                            
                            title = json["items"][i]["snippet"]["title"].string!
                            imageURLString = json["items"][i]["snippet"]["thumbnails"]["default"]["url"].string!
                            youtubeURL = "https://www.youtube.com/watch?v=\(videoID)"
                            channelTitle = json["items"][i]["snippet"]["channelTitle"].string!
                            
                             }else{continue}
                            
                            self.videoIdArrey.append(videoId!)
                            self.titleArrey.append(title)
                            self.imageURLArrey.append(imageURLString)
                            self.youtubeURLArrey.append(youtubeURL)
                            self.channelTitleArrey.append(channelTitle)
                     
                        }
                    HUD.hide()
                    self.performSegue(withIdentifier: "selectVC", sender: nil)
                    
                        
                case .failure(let error):
                     
                     print(error)
                    
                }
                  
                
            }
            
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if searchTextField.text != nil && segue.identifier == "selectVC" {
            
            let selectVC = segue.destination as! SelectViewController
                   
            selectVC.channelTitleArrey = self.channelTitleArrey
            selectVC.imageURLArrey = self.imageURLArrey
            selectVC.titleArrey = self.titleArrey
            selectVC.videoIdArrey = self.videoIdArrey
            selectVC.youtubeURLArrey = self.youtubeURLArrey
            selectVC.userName = self.userName
            selectVC.userID = self.userID
            
        }
       
    }
        
        
    
    
    @IBAction func logOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
               do {
                   try firebaseAuth.signOut()
                   print("SignOut is successed")
                   reloadInputViews()
               } catch let signOutError as NSError {
                   print("Error signing out: %@", signOutError)
                   
               }
               
        
        
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


