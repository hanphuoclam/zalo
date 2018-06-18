//
//  AddFriendViewController.swift
//  Zalo
//
//  Created by LamHan on 6/17/18.
//  Copyright © 2018 LamHan. All rights reserved.
//

import UIKit
import Firebase

class AddFriendViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var connectButton: customButton!
    
    var threadId : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextfield.placeholder = "Enter your friend's name"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectPressed(_ sender: UIButton) {
        let ThreadDB = Database.database().reference().child("threads")
        threadId = self.randomString(length: 20)
        userLookUpByEmail(email: usernameTextfield.text!, completionHandler: { (id) in
            if id != ""{
                let userId = ["userid":Auth.auth().currentUser?.uid, "userIdFriend": id]
                ThreadDB.child(self.threadId).child("users").setValue(userId)
                let userIdFriend = ["userid":id, "userIdFriend": Auth.auth().currentUser?.uid]
                ThreadDB.child(self.threadId).child("users").setValue(userIdFriend)
                let threadValue = ["threadId": self.threadId]
                Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("threads").child(self.threadId).setValue(threadValue){
                    (error,ref) in
                    if error != nil {
                        print("Add threadid to users success")
                    }else{
                        print("have a error when add thread in users")
                    }
                }
                Database.database().reference().child("users").child(id).child("threads").child(self.threadId).setValue(threadValue)
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
                
            }else{
                print("Username not found")
            }
        })
        
        
        
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    func userLookUpByEmail (email: String, completionHandler: @escaping (_ result: String) -> Void) {
        var userID: String = "nil"
        let UserDB = Database.database().reference()
        UserDB.child("emails").queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .childAdded, with: { snapshot in
            if snapshot.value != nil {
                print(snapshot.key)
                userID = snapshot.key
            }
            else {
                print ("user not found")
                userID = "nil"
            }
            completionHandler(userID)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ChatViewController {
            let chatVC = segue.destination as! ChatViewController
            chatVC.threadId = threadId
            print("thread id from add  \(threadId)")
        }
    }

}
