//
//  LoginVC.swift
//  FSA
//
//  Created by ka sing leung on 4/28/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passpordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createUserBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 10
        createUserBtn.layer.cornerRadius = 10
        
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
    }
    

    @IBAction func createUserTapped(_ sender: Any) {
    }
    
}
