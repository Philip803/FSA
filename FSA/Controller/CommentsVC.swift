//
//  CommentsVC.swift
//  FSA
//
//  Created by Philip Leung on 4/28/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController, UITableViewDelegate,UITableViewDataSource{

    //Variable
    var question : Question!
    var comments = [Comment]()
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentTxt: UITextField!
    @IBOutlet weak var keyboardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        print(question.questionTxt)
        
    }

    @IBAction func addCommentTapped(_ sender: Any) {
        
    }
    
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
