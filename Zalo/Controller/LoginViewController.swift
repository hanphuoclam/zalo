//
//  LoginViewController.swift
//  Zalo
//
//  Created by LamHan on 6/14/18.
//  Copyright © 2018 LamHan. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: customButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextfield.placeholder = "Username"
        passwordTextfield.placeholder = "Password"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        //TODO: do sign in user
        Auth.auth().signIn(withEmail: usernameTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error != nil {
                print(error!)
                return
            }else{
                //succes
                print("Login success")
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
        
    }
    

}
