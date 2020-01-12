//
//  AddPlaceViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/21/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import SwiftyJSON
import FirebaseDatabase
import FirebaseStorage

class AddPlaceViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var newImgPlc: UIImageView!
    @IBOutlet weak var newNamePlc: UITextField!
    @IBOutlet weak var name1: UITextView!
    var newImg: UIImage?
    var namePlcc: String?
    var textViewPlaceholderText = "What's on your mind?"
    
    @IBAction func backAction(_ sender: Any) {
        let des = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarViewController
        des?.selectedViewController = des?.viewControllers?[3]
        self.present(des!, animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        let des = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarViewController
        let alert = UIAlertController(title: "Lưu", message: "Bạn muốn chia địa điểm này?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Có", style: .default) {(action) in
            let newPost = Place(name: self.newNamePlc.text!, des: self.name1.text!, image: self.newImg!, typeShare: "true")
            newPost.savePlace()
            DispatchQueue.main.async {
                places.insert(newPost, at: 0)
                myLib.insert(newPost, at: 0)
            }
        }
        let noAction = UIAlertAction(title: "Không", style: .default, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true)
        des?.selectedViewController = des?.viewControllers?[3]
        self.present(des!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name1.text = textViewPlaceholderText
        name1.textColor = .lightGray
        name1.delegate = self
        
        let tapGestureToImageView = UITapGestureRecognizer(target: self, action: #selector(tapToImageView(sender:)))
        tapGestureToImageView.numberOfTapsRequired = 1
        newImgPlc?.isUserInteractionEnabled = true
        newImgPlc?.addGestureRecognizer(tapGestureToImageView)
    }
    //UIImage
    @objc func tapToImageView(sender: UITapGestureRecognizer){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage: UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        newImgPlc?.image = chosenImage
        newImg = chosenImage
        picker.dismiss(animated: true, completion: nil)
    }
    //UITexField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        namePlcc = newNamePlc?.text
        textField.resignFirstResponder()
    }
    //UITextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholderText {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
