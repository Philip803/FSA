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

class Question {
    
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var questionTxt: String!
    private(set) var numLikes: Int!
    private(set) var numComments: Int!
    private(set) var documentId: String!

    init(username: String, timestamp : Date, questionTxt : String, numLikes: Int, numComments: Int, documentId : String) {
        self.username = username
        self.timestamp = timestamp
        self.questionTxt = questionTxt
        self.numLikes = numLikes
        self.numComments = numComments
        self.documentId = documentId
    }
    
    class func parseData(snapshot : QuerySnapshot?) -> [Question] {
        var questions = [Question]()
        
        guard let snap = snapshot else {return questions}
        for document in snap.documents {
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Anonymous"   //default value
            let timestamp = data[TIMESTAMP] as? Date ?? Date()
            let questionTxt = data[QUESTION_TXT] as? String ?? ""
            let numLikes = data[NUM_LIKES] as? Int ?? 0
            let numComments = data[NUM_COMMENTS] as? Int ?? 0
            let documentId = document.documentID
            
            let newQuestion = Question(username: username, timestamp: timestamp, questionTxt: questionTxt, numLikes: numLikes, numComments: numComments, documentId: documentId)
            questions.append(newQuestion)
        }
        
        return questions
    }
    
    
}
