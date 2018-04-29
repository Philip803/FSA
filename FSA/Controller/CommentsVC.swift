//
//  CommentsVC.swift
//  FSA
//
//  Created by Philip Leung on 4/28/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit
import Firebase

class CommentsVC: UIViewController, UITableViewDelegate,UITableViewDataSource{

    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentTxt: UITextField!
    @IBOutlet weak var keyboardView: UIView!
    
    //Variable
    var question : Question!
    var comments = [Comment]()
    let firestore = Firestore.firestore()
//    var questionRef = DocumentReference
    var username: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        questionRef = firestore.collection(QUESTION_REF).document(question.documentId)
        if let name = Auth.auth().currentUser?.displayName {
            username = name
        }
    }

    //transaction for multiple read and write
//    @IBAction func addCommentTapped(_ sender: Any) {
    
//        guard let commentTxt = addCommentTxt.text else { return }
//
//        firestore.runTransaction({ (transaction, errorPointer) -> Any? in
//            //read before write
//            let questionDocument: DocumentSnapshot
//
//            do {
//                //read
//                try questionDocument = transaction.getDocument(Firestore.firestore().collection(QUESTION_REF).document(self.question.documentId))
//
//            } catch let error as NSError {
//                debugPrint("Fetch error: \(error.localizedDescription)")
//                return nil
//            }
//
//            guard let oldNumComments = questionDocument.data()[NUM_COMMENTS] as? Int else { return nil }
//
//            transaction.updateData([NUM_COMMENTS : oldNumComments + 1] , forDocument: Firestore.firestore().collection(QUESTION_REF).document(question.documentId))
//
//            //write
//            let newCommentRef = self.firestore.collection(QUESTION_REF).document(self.question.documentId).collection(COMMENTS_REF).document()
//
//            transaction.setData([
//                COMMENT_TXT : commentTxt,
//                TIMESTAMP: FieldValue.serverTimestamp(),
//                USERNAME : self.username
//                ], forDocument: newCommentRef)
//
//            return nil
//
//        }) { (object, error) in
//            if let error = error {
//                debugPrint("Transaction failed: \(error)")
//            } else {
//                self.addCommentTxt.text = ""
//                self.addCommentTxt.resignFirstResponder()
//            }
//        }
        
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentCell {
            
            cell.configureCell(comment: comments[indexPath.row])
            return cell
        }
    
        return UITableViewCell()
    }
    
}
