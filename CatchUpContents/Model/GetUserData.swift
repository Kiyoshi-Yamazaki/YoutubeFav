//
//  GetUserData.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/04.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import Foundation
import Firebase

class GetUserData {
    
    var userName:String = ""
    var userID :String = ""
    var userPass :String = ""
    
    var ref = Database.database().reference().child("Profile")
    
    
    init (snapshot :DataSnapshot){
        
        ref = snapshot.ref
        
        if let value = snapshot.value as? [String:Any]{
            
            userName = value["userName"] as! String
            userID = value["userID"] as! String
            userPass = value["userPass"] as! String
            
            
        }
        
        
    
    }
    
    
    
    
    
}
