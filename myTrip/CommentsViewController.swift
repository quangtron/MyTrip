//
//  CommentsViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/13/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

class CommentsViewController: UIViewController, UITextViewDelegate{
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeHolderLbl: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.backgroundColor = UIColor.gray
        doneButton.layer.cornerRadius = doneButton.bounds.height / 2
        doneButton.clipsToBounds = true
        
        textView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func handlePostButton() {
        
        guard let userProfile = UserService.currentUserProfile else { return }
        // Firebase code here
        
        let postRef = Database.database().reference().child("posts").childByAutoId()
        
        let postObject = [
            "author": [
                "uid": userProfile.uid,
                "username": userProfile.username,
                "photoURL": userProfile.photoURL.absoluteString
            ],
            "text": textView.text,
            "timestamp": [".sv":"timestamp"]
            ] as [String:Any]
        
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Handle the error
            }
        })
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        textView.resignFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            super.dismiss(animated: flag, completion: completion)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
        
        // Remove the nav shadow underline
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLbl.isHidden = !textView.text.isEmpty
    }
}
