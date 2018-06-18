//
//  ViewController.swift
//  Zalo
//
//  Created by LamHan on 6/14/18.
//  Copyright © 2018 LamHan. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var LoginButton: customButton!
    
    @IBOutlet weak var RegisterButton: UIButton!
    
    let underlineAttributes : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.foregroundColor : UIColor.lightGray,
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //LoginButton.customDesign()
        let attributeString = NSMutableAttributedString(string: "Register Now", attributes: underlineAttributes)
        RegisterButton.setAttributedTitle(attributeString, for: .normal)
        //Init()
    }
    func Init(){
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
}

extension UIButton {
    func customDesign(){
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 3.5
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}

class customButton : UIButton {
    override func didMoveToWindow() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 3.5
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}

