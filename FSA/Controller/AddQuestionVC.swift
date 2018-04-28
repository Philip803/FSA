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
    private var selectedCategory = QuestionCategory.easy.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postBtn.layer.cornerRadius = 4
        questionTxt.layer.cornerRadius = 4
        questionTxt.text = "My Random question..."
        questionTxt.delegate = self
        userNameTxt.text = "Anonymous"
    }

    //call when user begin typing
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        guard let username = userNameTxt.text else { return }
        
        Firestore.firestore().collection("questions").addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_LIKES : 0,
            NUM_COMMENTS : 0,
            QUESTION_TXT : questionTxt.text,
            TIMESTAMP : FieldValue.serverTimestamp(),
            USERNAME : username
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
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = QuestionCategory.easy.rawValue
        case 1:
            selectedCategory = QuestionCategory.normal.rawValue
        default:
            selectedCategory = QuestionCategory.hard.rawValue
        }
    }
    
}
