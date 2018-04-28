//
//  QuestionCell.swift
//  FSA
//
//  Created by ka sing leung on 4/27/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var questionTxtLabel: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    @IBOutlet weak var likesNumLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell ( question : Question){
        usernameLabel.text = question.username
        questionTxtLabel.text = question.questionTxt
        likesNumLabel.text = String(question.numLikes)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: question.timestamp)
        timestampLabel.text = timestamp
    }
    
}
