//
//  Custom.swift
//  Zalo
//
//  Created by LamHan on 6/17/18.
//  Copyright © 2018 LamHan. All rights reserved.
//

import UIKit
import Firebase

extension MainViewController{
    func customNavigateForMainView(){
        customTitleNavBar()
        customRightNavBar()
        customLeftNavBar()
    }
    
    //TODO: Declare Custom title to search bar
    private func customTitleNavBar(){
        
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    //TODO: Declare Custom right button naviagtion bar
    private func customRightNavBar(){
        let addButton = UIButton(type: .system)
        addButton.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal), for: .normal)
        addButton.frame = CGRect(x: 1, y: 1, width: 34, height: 34)
        addButton.contentMode = .scaleAspectFit
        addButton.widthAnchor.constraint(equalToConstant: addButton.frame.size.width).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: addButton.frame.size.height).isActive = true
        addButton.addTarget(self, action: #selector(addFriend), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
    
    @objc func addFriend() {
        performSegue(withIdentifier: "goToAddFriend", sender: self)
    }
    
    //TODO: Declare Custom left button naviagtion bar
    private func customLeftNavBar(){
        let logoutButton = UIButton(type: .system)
        logoutButton.setImage(#imageLiteral(resourceName: "logout").withRenderingMode(.alwaysOriginal), for: .normal)
        logoutButton.frame = CGRect(x: 1, y: 1, width: 34, height: 34)
        logoutButton.contentMode = .scaleAspectFit
        logoutButton.widthAnchor.constraint(equalToConstant: logoutButton.frame.size.width).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: logoutButton.frame.size.height).isActive = true
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoutButton)
    }
    @objc func logout(){
        //TODO: Log out the user and send them back to WelcomeViewController
        let logoutAlert = UIAlertController(title: "Log Out", message: "Are you sure!", preferredStyle: UIAlertControllerStyle.alert)
        
        logoutAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            do {
                try Auth.auth().signOut()
            }catch {
                print("error: There was a problem signing out")
            }
            
            guard (self.navigationController?.popToRootViewController(animated: true)) != nil
                else{
                    print("No view controller to pop off")
                    return
            }
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancle")
        }))
        
        present(logoutAlert, animated: true, completion: nil)
        
    }
}
