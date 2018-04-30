//
//  BeforeCoreMLVC.swift
//  FSA
//
//  Created by Philip Leung on 4/29/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit

class BeforeCoreMLVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func translateTapped(_ sender: Any) {
        
        let translator = ROGoogleTranslate()
        translator.apiKey = "AIzaSyBzXaETa-6fM1pPVdsf2LXhkQqaKFIBYAs" // Add your API Key here
        
        var params = ROGoogleTranslateParams(source: "en",
                                             target: "es",
                                             text:   "Here you can add your sentence you want to be translated")

        translator.translate(params: params) { (result) in
            DispatchQueue.main.async {
                print(result)
            }
        }
    }
    
}
