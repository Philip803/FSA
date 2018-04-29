//
//  Comment.swift
//  FSA
//
//  Created by Philip Leung on 4/28/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import Foundation

//
//  Question.swift
//  FSA
//
//  Created by ka sing leung on 4/27/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import Foundation
import Firebase

//data download from database

class Comment {
    
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var commentTxt: String!
    
    init(username: String, timestamp : Date, commentTxt : String) {
        self.username = username
        self.timestamp = timestamp
        self.commentTxt = commentTxt
       
    }
    
//    class func parseData(snapshot : QuerySnapshot?) -> [Question] {
//        var questions = [Question]()
//
//        guard let snap = snapshot else {return questions}
//        for document in snap.documents {
//            let data = document.data()
//            let username = data[USERNAME] as? String ?? "Anonymous"   //default value
//            let timestamp = data[TIMESTAMP] as? Date ?? Date()
//            let questionTxt = data[QUESTION_TXT] as? String ?? ""
//            let numLikes = data[NUM_LIKES] as? Int ?? 0
//            let numComments = data[NUM_COMMENTS] as? Int ?? 0
//            let documentId = document.documentID
//            
//            let newQuestion = Question(username: username, timestamp: timestamp, questionTxt: questionTxt, numLikes: numLikes, numComments: numComments, documentId: documentId)
//            questions.append(newQuestion)
//        }
//
//        return questions
//    }
    
    
}
