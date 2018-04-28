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
    case easy,normal,hard,popular
}

class MainVC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    //Variables
    private var questions = [Question]()
    private var questionsCollectionRef : CollectionReference!
    private var questionsListener: ListenerRegistration!
    private var selectedCategory = QuestionCategory.easy.rawValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //set up dynamic question size 
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        questionsCollectionRef = Firestore.firestore().collection(QUESTION_REF)
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            selectedCategory = QuestionCategory.easy.rawValue
        case 1:
            selectedCategory = QuestionCategory.normal.rawValue
        case 2:
            selectedCategory = QuestionCategory.hard.rawValue
        default:
            selectedCategory = QuestionCategory.popular.rawValue
        }
        
        questionsListener.remove()
        setListener()
    }
    
    func setListener(){

        if selectedCategory == QuestionCategory.popular.rawValue {
            questionsListener = questionsCollectionRef
                .order(by: NUM_LIKES, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let err = error {
                        debugPrint("Error fetching docs: \(err)")
                    } else {
                        self.questions.removeAll()
                        self.questions = Question.parseData(snapshot: snapshot)
                        self.tableView.reloadData()
                    }
            }
        } else {
            
            questionsListener = questionsCollectionRef
                .whereField(CATEGORY, isEqualTo: selectedCategory)
                .order(by: TIMESTAMP, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let err = error {
                        debugPrint("Error fetching docs: \(err)")
                    } else {
                        self.questions.removeAll()
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
        
    }
    
    //fetch data from db when view appear
    override func viewWillAppear(_ animated: Bool) {
        setListener()
        
//        questionsCollectionRef.getDocuments // one time
    }

    //del arr when leave view for best practice
    override func viewDidDisappear(_ animated: Bool) {
        questionsListener.remove()
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

