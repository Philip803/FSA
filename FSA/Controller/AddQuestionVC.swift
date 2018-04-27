//
//  AddQuestionVC.swift
//  FSA
//
//  Created by ka sing leung on 4/26/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit

class AddQuestionVC: UIViewController , UITextViewDelegate{

    //OutLets
    @IBOutlet weak var categorySegment: UISegmentedControl!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var questionTxt: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postBtn.layer.cornerRadius = 4
        questionTxt.layer.cornerRadius = 4
        questionTxt.text = "My Random question..."
        questionTxt.delegate = self
    
    }

    //call when user begin typing
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
    }
    
}
