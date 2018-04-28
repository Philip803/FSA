//
//  CreateUserVC.swift
//  FSA
//
//  Created by ka sing leung on 4/28/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit

class CreateUserVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var createBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10

    }

    @IBAction func createTapped(_ sender: Any) {
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
    }
    

}
