//
//  MoreViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/11/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Firebase

class MoreViewController: UIViewController {
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLib = []
        Database.database().reference().child((UserService.currentUserProfile?.uid)!).observe(.childAdded) { (snapshot) in
            let newPlace = Place(snapshot: snapshot, key: (UserService.currentUserProfile?.uid)!)
            DispatchQueue.main.async {
                myLib.insert(newPlace, at: 0)
            }
        }
        
        DispatchQueue.main.async {
            self.nameUser.text = (UserService.currentUserProfile?.username)!
            let data = try? Data(contentsOf: (UserService.currentUserProfile?.photoURL)!)
            let image = UIImage(data: data!)
            self.imageUser.image = image
        }
    }
    
    @IBAction func handleLogout(_ sender:Any) {
        try! Auth.auth().signOut()
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        let des = self.storyboard?.instantiateViewController(withIdentifier: "naviShare") as? UINavigationController
        self.present(des!, animated: true, completion: nil)
    }
    
    @IBAction func libraryAction(_ sender: UIButton) {
        let des = self.storyboard?.instantiateViewController(withIdentifier: "saveNavigation") as? UINavigationController
        self.present(des!, animated: true, completion: nil)
    }
    
    @IBAction func addAction(_ sender: Any) {
        let des = self.storyboard?.instantiateViewController(withIdentifier: "naviAdd") as? UINavigationController
        self.present(des!, animated: true, completion: nil)
    }
}
