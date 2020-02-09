//
//  RegisterViewController.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/01.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class RegisterViewController: UIViewController,UITextFieldDelegate,GIDSignInDelegate{

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPassTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameTextField.delegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
      
        
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        userNameTextField.resignFirstResponder()
        userPassTextField.resignFirstResponder()
      
        
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        if (userNameTextField!.text != nil), userPassTextField.text != nil {
                   
                   UserDefaults.standard.set(userNameTextField.text, forKey: "userName")
                   UserDefaults.standard.set(userPassTextField.text, forKey: "userPass")
                   
               }else{
                   
                   let alert = Alert()
                   alert.showAlert(title: "エラー", message: "入力が不十分です", viewController: self)
            
                   let generator = UINotificationFeedbackGenerator()
                   generator.notificationOccurred(.error)
                   return
               }
               
               Auth.auth().signInAnonymously { (result, error) in
                   
                   if error == nil {
                       
                    guard let user = result?.user else {return}
                    let userID = user.uid
                    UserDefaults.standard.set(userID, forKey: "userID")
                    
                    let saveProfile = ProfileData(userID: userID, userName: self.userNameTextField.text!,userPass:self.userPassTextField.text!)
                    saveProfile.saveProfile()
                    self.dismiss(animated: true, completion: nil)
                       
                       
                   }else{
                       
                       print(error?.localizedDescription as Any)
                       
                   }
                   
                   
               }
        
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        // ...
        print(error.localizedDescription)
        return
      }
        print("ここまで")
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("認証\(error.localizedDescription)")
                return
            }
            print("google認証成功")
            self.dismiss(animated: true, completion: nil)
            // User is signed in
            // ...
        }
      // ...
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
