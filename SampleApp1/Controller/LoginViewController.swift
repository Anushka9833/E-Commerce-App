//
//  LoginViewController.swift
//  SampleApp1
//
//  Created by Anmol Kumar on 18/07/19.
//  Copyright © 2019 Anushka. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {

//MARK:- Outlets for textfields
    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!
    
    
//MARK:- viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//MARK:- logInButton
    @IBAction func logInButton(_ sender: Any) {
        
        if(userName.text=="user1")&&(password.text=="123"){
            
            UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
            UserDefaults.standard.setValue("user1", forKey: "email")
            UserDefaults.standard.synchronize()
            
            
            let storyb = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyb.instantiateViewController(withIdentifier: "tvc") as! UITabBarController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            print("invalid id")
            let alertController = UIAlertController(title: "ALERT", message: "Invalid Username or Password", preferredStyle: .alert)
           
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
          
            alertController.addAction(cancel)
            self.present(alertController, animated: true, completion: nil)
            
            
            
        }
    }
    
    
    
    
}
