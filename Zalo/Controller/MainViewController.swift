//
//  MainViewController.swift
//  Zalo
//
//  Created by LamHan on 6/14/18.
//  Copyright © 2018 LamHan. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var listMessageTableView: UITableView!
    
    private var listMessage : [ReviewMessage] = []
    private var listThreadId : [String] = []
    //private var listUserId : [String] = []
    var threadId : String = ""
    var Name : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: Set yourself as delegate and datasource of TableView
        listMessageTableView.dataSource = self
        listMessageTableView.delegate = self
        
        //TODO: Register your customAddressCell.xib
        listMessageTableView.register(UINib(nibName: "MessageCell", bundle:nil), forCellReuseIdentifier: "messageCell")
        
        getThreadFromUserId(userId: (Auth.auth().currentUser?.uid)!)
        //TODO: Call method custom navigate from custom file
        customNavigateForMainView()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView Method
    
    //TODO: Declare cellForRowAtIndexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell
        cell.avatarImageView.image = UIImage(named: "add")
        cell.nameTextfield.text = listMessage[indexPath.row].name
        cell.contentReviewTextfield.text = listMessage[indexPath.row].contentMeseageReview
        
        return cell
    }
    
    //TODO: Declare numberOfRowInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessage.count
    }
    
    //TODO: Declare didSelectRowAtIndexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        threadId = listThreadId[indexPath.row]
        Name = listMessage[indexPath.row].name
        performSegue(withIdentifier: "goToChat", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ChatViewController {
            let chatVC = segue.destination as! ChatViewController
            chatVC.threadId = threadId
            chatVC.Name = Name
            print("thread id from main  \(threadId)")
        }
    }
    
    //TODO: Declare retrieveListMesage
    func retrieveListMessage(userId : String) {
        
        let UserDB = Database.database().reference().child("users")
        
        let UserInfo = UserDB.child(userId)
        print("list user id new create : \(userId)")
        UserInfo.observe(.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                let snapshotValue = snapshot.value as? Dictionary<String,AnyObject>
                
                let reviewMessage = ReviewMessage()
                reviewMessage.avatarName = userId//snapshotValue!["userid"]!
                if let name = snapshotValue!["displayName"]{
                    reviewMessage.name = name as! String
                    reviewMessage.contentMeseageReview = name as! String
                }
                
                self.listMessage.append(reviewMessage)
                self.listMessageTableView.reloadData()
            }
        }
    }
    
    private func getUserIdFromThreadId(threadId: String){
        if threadId != ""{
            let threadDB = Database.database().reference().child("threads")
            let userId = threadDB.child(threadId).child("users")
            userId.observe(.value) { (snapshot) in
                if snapshot.childrenCount > 0 {
                    let snapshotValue = snapshot.value as? Dictionary<String,String>
                    var useridfriend = snapshotValue!["userIdFriend"]!
                    if useridfriend.isEqual(Auth.auth().currentUser?.uid){
                        useridfriend = snapshotValue!["userid"]!
                    }
                    
                    self.retrieveListMessage(userId: useridfriend)
                }
            }
        }
    }
    
    private func getThreadFromUserId(userId: String){
        //SVProgressHUD.show()
        let db = Database.database().reference().child("users").child(userId).child("threads")
        db.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as? [String:AnyObject]
            if snapshot.childrenCount > 0 {
                print("Thread Id in users : \(snapshotValue!["threadId"]!)")
                self.listThreadId.append(snapshotValue!["threadId"] as! String)
                let threadIdInUsers = snapshotValue!["threadId"]
                //SVProgressHUD.dismiss()
                //print("lis thread : \(self.listThreadId)")
                self.getUserIdFromThreadId(threadId: threadIdInUsers as! String)
            }else{
                SVProgressHUD.dismiss()
            }
        }
    }
    
}
