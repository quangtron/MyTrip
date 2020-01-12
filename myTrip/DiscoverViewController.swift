//
//  DiscoverViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/1/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DiscoverViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UIButton {
    func applyDesign(){
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
