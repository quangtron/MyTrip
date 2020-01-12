//
//  MainTabBarViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/11/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            places = []
            Database.database().reference().child("places").observe(.childAdded) { (snapshot) in
                let newPlace = Place(snapshot: snapshot)
                DispatchQueue.main.async {
                    places.insert(newPlace, at: 0)
                }
            }
            
            beaches = []
            Database.database().reference().child("topBeaches").observe(.childAdded) { (snapshot) in
                let newPlace = Place(snapshot: snapshot, key: "topBeaches")
                DispatchQueue.main.async {
                    beaches.insert(newPlace, at: 0)
                }
            }
        }
    }
}
