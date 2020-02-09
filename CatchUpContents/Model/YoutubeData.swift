//
//  YoutubeData.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/02.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import Foundation
import Firebase


class YoutubeData{
    
    var videoId :String = ""
    var title :String = ""
    var imageURLString :String = ""
    var youtubeURL :String = ""
    var channelTitle :String = ""
    var userName :String! = ""
    var userID :String! = ""
    
    let ref:DatabaseReference!
    
   
    
    init (channelTitle:String,title:String,videoId:String,imageURLString:String,youtubeURL:String,userName:String,userID:String){
           
           self.channelTitle = channelTitle
           self.title = title
           self.videoId = videoId
           self.imageURLString = imageURLString
           self.youtubeURL = youtubeURL
           self.userName = userName
           self.userID = userID
           print(userID)
           
           ref = Database.database().reference().child("users").child(userID).childByAutoId()
           
       }
       
       init (snapshot:DataSnapshot){
           
           ref = snapshot.ref
           if let value = snapshot.value as? [String:Any]{
               
                channelTitle = (value["channelTitle"] as? String)!
                title = (value["title"] as? String)!
                videoId = (value["videoId"] as? String)!
                imageURLString = (value["imageURLString"] as? String)!
                youtubeURL = value["youtubeURL"] as! String
                userID = value["userID"] as? String
                userName = value["userName"] as? String
               
           }
           
       }
    
    func toContents()->[String:Any]{
        
        return ["channelTitle":channelTitle,"title":title,"videoId":videoId,"imageURLString":imageURLString,"youtubeURL":youtubeURL,"userID":userID!,"userName":userName!]
        
    }
    
    func save(){
        
        ref.setValue(toContents())
        
    }
    
    
}
