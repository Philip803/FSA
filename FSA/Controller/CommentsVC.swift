//
//  CommentsVC.swift
//  FSA
//
//  Created by Philip Leung on 4/28/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController {

    //Variable
    var question : Question!
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentTxt: UITextField!
    @IBOutlet weak var keyboardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    @IBAction func addCommentTapped(_ sender: Any) {
    }
    
}
