//
//  Alert.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/01.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    let title :String = ""
    let message :String = ""
    
    
    func showAlert(title:String,message:String,viewController:UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "戻る", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}
