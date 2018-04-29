//
//  User.swift
//  FSA
//
//  Created by Philip Leung on 4/28/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var status: String!

    
    init(username: String, timestamp : Date, status : String) {
        self.username = username
        self.timestamp = timestamp
        self.status = status
    }
    
    class func parseData(snapshot : QuerySnapshot?) -> [User] {
        var user = [User]()
        
        guard let snap = snapshot else {return user}
        for document in snap.documents {
            let data = document.data()
            let username = data["name"] as? String ?? "Anonymous"   //default value
            let timestamp = data[TIMESTAMP] as? Date ?? Date()
            let status = data["status"] as? String ?? ""
            
            let newUserInfo = User(username: username, timestamp: timestamp, status: status)
            
            user.append(newUserInfo)
        }
        
        return user
    }
    
    
}
