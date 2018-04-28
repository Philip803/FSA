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
    private var handle: AuthStateDidChangeListenerHandle?   //handle user auth access token
    
    
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
    
    //fetch data from db when view appear
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user == nil {
                //not login
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC")
                self.present(loginVC, animated: true, completion: nil)
            } else {
                self.setListener()
            }
        })
        // questionsCollectionRef.getDocuments // one time fetch data
    }
    
    //del arr when leave view for best practice
    override func viewDidDisappear(_ animated: Bool) {
        //only remove if listener loaded from server
        if questionsListener != nil {
            questionsListener.remove()
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        let firebasesAuth = Auth.auth()
        do {
            try firebasesAuth.signOut()
        } catch let signoutError as NSError {
            debugPrint("Error signing out \(signoutError)")
        }
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
                        self.questions = Question.parseData(snapshot: snapshot)
                        self.tableView.reloadData()
                }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   performSegue(withIdentifier: "toComments", sender: questions[indexPath.row])
    }
    
    //pre check before segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toComments" {
            if let destinationVC = segue.destination as? CommentsVC {
                if let question = sender as? Question {
                    destinationVC.question = question   //passint to comments variable
                }
            }
        }
    }
}



