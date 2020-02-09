//
//  ProfileData.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/01.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import Foundation
import Firebase

class ProfileData{
    
    var userID :String! = ""
    var userName : String! = ""
    var userPass :String! = ""
    var ref : DatabaseReference!
      
      
    init(userID:String,userName:String,userPass:String){
          
        self.userID = userID
        self.userName = userName
        self.userPass = userPass
        ref = Database.database().reference().child("Profile").childByAutoId()
          
      }

      init(snapShot:DataSnapshot){
          
        ref = snapShot.ref
        if let value = snapShot.value as? [String:Any] {
            
              userID = value["userID"] as? String
              userName = value["userName"] as? String
              userPass = value["userPass"] as? String
          }
      }
      
      func toContents() -> [String:Any] {
          
          return ["userID":userID,"userName":userName,"userPass":userPass as Any]
          
      }
      
      func saveProfile(){
          
          ref.setValue(toContents())
          UserDefaults.standard.set(ref.key, forKey: "autoID")
          
      }
      
      
    
    
    
    
    
    
    
}

