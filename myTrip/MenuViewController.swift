//
//  MenuViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/8/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var loginWithFacebook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*places = []
        Database.database().reference().child("places").observe(.childAdded) { (snapshot) in
            let newPlace = Place(snapshot: snapshot)
            DispatchQueue.main.async {
                places.insert(newPlace, at: 0)
            }
        }*/
        loginButton.DesignButton()
        loginWithFacebook.DesignButton()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension UIButton {
    func DesignButton(){
        //self.backgroundColor = UIColor.blue
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
