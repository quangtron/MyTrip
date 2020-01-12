//
//  HomeViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/9/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var comment = [Comments]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var layoutGuide:UILayoutGuide!
        
        if #available(iOS 11.0, *) {
            layoutGuide = view.safeAreaLayoutGuide
        } else {
            // Fallback on earlier versions
            layoutGuide = view.layoutMarginsGuide
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        observePosts()
        // Do any additional setup after loading the view.
    }
    
    func observePosts() {
        let postsRef = Database.database().reference().child("posts")
        
        postsRef.observe(.value, with: { snapshot in
            
            var tempPosts = [Comments]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["author"] as? [String:Any],
                    let uid = author["uid"] as? String,
                    let username = author["username"] as? String,
                    let photoURL = author["photoURL"] as? String,
                    let url = URL(string:photoURL),
                    let text = dict["text"] as? String,
                    let timestamp = dict["timestamp"] as? Double {
                    
                    let userProfile = UserProfile(uid: uid, username: username, photoURL: url)
                    let post = Comments(id: childSnapshot.key, author: userProfile, text: text, timestamp:timestamp)
                    tempPosts.append(post)
                }
            }
            
            self.comment = tempPosts
            self.tableView.reloadData()
            
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell") as! CommentsTableViewCell
        cell.set(comments: comment[indexPath.row])
        return cell
    }
}
