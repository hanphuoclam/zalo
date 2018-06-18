//
//  RegisterStepOneViewController.swift
//  Zalo
//
//  Created by LamHan on 6/15/18.
//  Copyright © 2018 LamHan. All rights reserved.
//

import UIKit

class RegisterStepOneViewController: UIViewController {

    @IBOutlet weak var displayNameTextfield: UITextField!
    
    @IBOutlet weak var continueButton: customButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNameTextfield.placeholder = "Enter your full name"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TODO: Declare prepare to change data to another view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is RegisterViewController
        {
            let registerVC = segue.destination as? RegisterViewController
            registerVC?.displayName = displayNameTextfield.text!
        }
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        //TODO: Method call RegisterView
        print(displayNameTextfield.text!)
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
    
}
