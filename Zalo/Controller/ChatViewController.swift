//
//  ChatViewController.swift
//  Zalo
//
//  Created by LamHan on 6/14/18.
//  Copyright © 2018 LamHan. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentMessageTextfield: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    
    var Messages : [Message] = []
    var threadId : String = ""
    var Name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Name
        //TODO: Set yourself as delegate and datasource of TableView
        messageTableView.dataSource = self
        messageTableView.delegate = self
        
        //TODO: Set yourself as delegate of TextField
        contentMessageTextfield.delegate = self
        
        //TODO: Set tapGesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        //TODO: Register your customMessageCell.xib and customMessageCellGuest.xib
        messageTableView.register(UINib(nibName: "CellMessageForOtherUser", bundle: nil), forCellReuseIdentifier: "cellMessageForOtherUser")
        messageTableView.register(UINib(nibName: "CellMessageForCurrentUser", bundle: nil), forCellReuseIdentifier: "cellMessageCurrentUser")
        configureTableView()
        retrieveMessage()
        
        messageTableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /////////////////////////////////////
    
    //MARK: - TableView Datasource Method
    
    //TODO: Declare cellForRowAtIndexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        if Auth.auth().currentUser?.email != Messages[indexPath.row].sender {
            let customCell = tableView.dequeueReusableCell(withIdentifier: "cellMessageForOtherUser", for: indexPath) as! CellMessageForOtherUser
            customCell.avatarImageView.image = UIImage(named: "add")
            customCell.contentTextfield.text = Messages[indexPath.row].content
            cell = customCell
        }else{
            let customCell = tableView.dequeueReusableCell(withIdentifier: "cellMessageCurrentUser", for: indexPath) as! CellMessageForCurrentUser
            customCell.contentMessageTextfield.text = Messages[indexPath.row].content
            cell = customCell
        }
        
        return cell
    }
    
    //TODO: Declare numberOfRowInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Messages.count
    }
    //TODO: Declare tableviewTapped
    @objc func tableViewTapped(){
        contentMessageTextfield.endEditing(true)
    }
    
    //TODO: Declare configureTableView
    func configureTableView()
    {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120
    }
    
    /////////////////////////////////////
    
    //MARK: - TextField Method
    
    //TODO: Declare textFieldDidBeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5){
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillShow(notify: NSNotification){

        if let keyboardSize = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.5) {
                self.heightConstraint.constant = keyboardSize.height
            }
        }
    }
    
    //TODO: Declare textFieldDidEndEditing
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5){
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    /////////////////////////////////////
    
    //MARK: - Send and recieve from Firebase
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        contentMessageTextfield.endEditing(true)
        //TODO: Send the message to Firebase and save it in our database
        contentMessageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messageDB = Database.database().reference().child("threads").child(threadId).child("messages")
        let messageDictionary = ["sender":Auth.auth().currentUser?.email, "content" : contentMessageTextfield.text!,"timestamp":"","date":""]
        
        messageDB.childByAutoId().setValue(messageDictionary){
            (error,ref) in
            if error != nil {
                print(error!)
            }else{
                print("Message saved successfuly")
                
                self.contentMessageTextfield.text = ""
                self.contentMessageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
            }
        }
    }
    
    //TODO: Declare retrieveMessage method
    func retrieveMessage() {
        let messageDB = Database.database().reference().child("threads").child(threadId).child("messages")
        messageDB.observe(.childAdded) { (snapshot) in
            if snapshot.childrenCount > 0 {
                let snapshotValue = snapshot.value as! Dictionary<String,String>
                
                let message = Message()
                message.content = snapshotValue["content"]!
                message.sender = snapshotValue["sender"]!
                message.timestamp = ""
                message.date = ""
                
                self.Messages.append(message)
                self.configureTableView()
                self.messageTableView.reloadData()
            }
        }
    }

    
}
