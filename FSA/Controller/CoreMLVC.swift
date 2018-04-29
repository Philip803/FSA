//
//  CoreMLVC.swift
//  FSA
//
//  Created by Philip Leung on 4/29/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit
import AVKit
import Vision

class CoreMLVC: UIViewController {

    @IBOutlet weak var captureImageView: RoundedShadowImageView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var flashBtn: RoundedShowButton!
    @IBOutlet weak var identificationLbl: UILabel!
    @IBOutlet weak var confidenceLbl: UILabel!
    @IBOutlet weak var roundedLblView: RoundedShadowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // start up the camera
        
     }
 
}
