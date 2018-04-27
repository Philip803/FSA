//
//  Question.swift
//  FSA
//
//  Created by ka sing leung on 4/27/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import Foundation

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
    
}
