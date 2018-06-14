//
//  ChatViewController.swift
//  Zalo
//
//  Created by LamHan on 6/14/18.
//  Copyright © 2018 LamHan. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentMessageTextfield: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: Set yourself as delegate and datasource of TableView
        
        
        //TODO: Set yourself as delegate of TextField
        
        
        //TODO: Set tapGesture
        
        
        //TODO: Register your customMessageCell.xib and customMessageCellGuest.xib
        
        messageTableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /////////////////////////////////////
    
    //MARK: - TableView Datasource Method
    
    //TODO: Declare cellForRowAtIndexPath
    
    //TODO: Declare numberOfRowInSection
    
    //TODO: Declare tableviewTapped
    
    //TODO: Declare configureTableView
    
    /////////////////////////////////////
    
    //MARK: - TextField Method
    
    //TODO: Declare textFieldDidBeginEditing
    
    //TODO: Declare textFieldDidEndEditing
    
    /////////////////////////////////////
    
    //MARK: - Send and recieve from Firebase
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        //TODO: Send message to Firebase and save it
        
    }
    
    //TODO: Declare retrieveMessage method
    

}
