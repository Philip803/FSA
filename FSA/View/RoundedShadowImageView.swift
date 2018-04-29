//
//  RoundedShadowImageView.swift
//  FSA
//
//  Created by Philip Leung on 4/29/18.
//  Copyright © 2018 Philip Leung. All rights reserved.
//

import UIKit

class RoundedShadowImageView: UIImageView {

    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.75
        self.layer.cornerRadius = 15   
    }

}
