//
//  ViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/1/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

// key:AIzaSyATyagHwabNsnGSmH4r5RT5JKrhjjMvq0w

import UIKit
import Foundation
import FirebaseDatabase
import GoogleMaps

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.performSegue(withIdentifier: "toMainScreen", sender: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
}
