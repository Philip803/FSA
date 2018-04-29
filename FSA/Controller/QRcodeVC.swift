//
//  QRcodeVC.swift
//  FSA
//
//  Created by Philip Leung on 4/28/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit
import Firebase

class QRcodeVC: UIViewController {

    private var userCollectionRef : CollectionReference!
    private var userListener : ListenerRegistration!
    
    @IBOutlet weak var checkInStatusTxt: UILabel!
    @IBOutlet weak var checkInTime: UILabel!
    
    private var userArr = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userCollectionRef = Firestore.firestore().collection("users")
    }

    override func viewWillAppear(_ animated: Bool) {
        print("HIT HERE")
        userListener = userCollectionRef
            .whereField("name", isEqualTo: "omri")
            .order(by: TIMESTAMP, descending: true)
            .addSnapshotListener { (snapshot, error) in
                if let err = error {
                    debugPrint("Error fetching docs: \(err)")
                } else {
                    self.userArr.removeAll()
                    self.userArr = User.parseData(snapshot: snapshot)
                    print(self.userArr[0].status)
                    self.checkInTime.text = self.userArr[0].status
                }
        }
    }
    
    
}
