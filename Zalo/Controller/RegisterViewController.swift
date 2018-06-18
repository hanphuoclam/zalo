//
//  RegisterViewController.swift
//  Zalo
//
//  Created by LamHan on 6/14/18.
//  Copyright © 2018 LamHan. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var registerButton: customButton!
    
    var displayName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextfield.placeholder = "Phone number or email"
        passwordTextfield.placeholder = "Password"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        //TODO: Create username and password to our firebase
        Auth.auth().createUser(withEmail: usernameTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error != nil {
                print(error!)
                return
            }else {
                SVProgressHUD.dismiss()
                //Success
                print("Create account succesful")
                
                //TODO: Create new brach user in database (Firebase)
                let userDB = Database.database().reference().child("users")
                userDB.child((Auth.auth().currentUser?.uid)!).setValue((Auth.auth().currentUser?.uid)!)
                {
                    (error,ref) in
                    if error != nil{
                        print("Add uid child has error : \(error!)")
                    }else{
                        print("Add uid child success")
                    }
                }
                let userInfo = ["displayName":self.displayName,"userid":Auth.auth().currentUser?.uid]
                userDB.child((Auth.auth().currentUser?.uid)!).setValue(userInfo)
                {
                    (error,ref) in
                    if error != nil{
                        print("Add user info has error : \(error!)")
                    }else{
                        print("Add user info child success")
                    }
                }
                Database.database().reference().child("emails").child((Auth.auth().currentUser?.uid)!).setValue(["email":Auth.auth().currentUser?.email])
                
                
                self.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
        
    }
    

}
