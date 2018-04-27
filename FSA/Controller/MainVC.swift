//
//  ViewController.swift
//  FSA
//
//  Created by Philip Leung on 4/25/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit
import Firebase

enum QuestionCategory: Swift.String {
    case easy,normal,crazy,popular
}

class MainVC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    //Variables
    private var questions = [Question]()
    private var questionsCollectionRef : CollectionReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //set up dynamic question size 
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        questionsCollectionRef = Firestore.firestore().collection(QUESTION_REF)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //fetch call
        questionsCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else {return}
                for document in snap.documents {
                    let data = document.data()
                    let username = data[USERNAME] as? String ?? "Anonymous"   //default value
                    let timestamp = data[TIMESTAMP] as? Date ?? Date()
                    let questionTxt = data[QUESTION_TXT] as? String ?? ""
                    let numLikes = data[NUM_LIKES] as? Int ?? 0
                    let numComments = data[NUM_COMMENTS] as? Int ?? 0
                    let documentId = document.documentID
                    
                    let newQuestion = Question(username: username, timestamp: timestamp, questionTxt: questionTxt, numLikes: numLikes, numComments: numComments, documentId: documentId)
                    self.questions.append(newQuestion)
                }
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as? QuestionCell {
            cell.configureCell(question : questions[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    
}

