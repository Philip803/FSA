//
//  QuestionCell.swift
//  FSA
//
//  Created by ka sing leung on 4/27/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit
import Firebase

class QuestionCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var questionTxtLabel: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    @IBOutlet weak var likesNumLabel: UILabel!
    
    //Variable
    private var question: Question!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImg.addGestureRecognizer(tap)
        likesImg.isUserInteractionEnabled = true
    }
    
    //swift 4 -> obj c
    @objc func likeTapped(){
        //Method 1
//        Firestore.firestore().collection(QUESTION_REF).document(question.documentId).setData(["numLikes" : question.numLikes + 1], options: SetOptions.merge())
        //merge numLikes to exists data, otherwise del all
        
        //Method 2
        Firestore.firestore().document("questions/\(question.documentId!)")
        .updateData([NUM_LIKES  : question.numLikes + 1])
        
    }

    func configureCell ( question : Question){
        self.question = question
        usernameLabel.text = question.username
        questionTxtLabel.text = question.questionTxt
        likesNumLabel.text = String(question.numLikes)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: question.timestamp)
        timestampLabel.text = timestamp
    }
    
}
