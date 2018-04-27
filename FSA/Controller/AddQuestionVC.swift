//
//  AddQuestionVC.swift
//  FSA
//
//  Created by ka sing leung on 4/26/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit
import Firebase

class AddQuestionVC: UIViewController , UITextViewDelegate{

    //OutLets
    @IBOutlet weak var categorySegment: UISegmentedControl!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var questionTxt: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    
    //Variables
    private var selectedCategory = "funny"
    
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
        Firestore.firestore().collection("questions").addDocument(data: [
            "category" : selectedCategory,
            "numComments" : 0,
            "numLikes" : 0,
            "questionTxt" : questionTxt.text,
            "timestamp" : FieldValue.serverTimestamp(),
            "username" : userNameTxt.text!
        ]) { (err) in
            if let err = err {
                debugPrint("Error adding document: \(err)")
            } else {
                //if success then go back to previous page
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        
    }
    
}
