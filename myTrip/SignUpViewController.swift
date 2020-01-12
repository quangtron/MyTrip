//
//  SignUpViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/8/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var changeImageButton: UIButton!
    
    var continueButton:DesigbButton!
    var activityView:UIActivityIndicatorView!
    var imagePicker : UIImagePickerController!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpContinueButton()
        self.setUpImage()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func actionDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func setUpContinueButton(){
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        continueButton = DesigbButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton.setTitleColor(secondaryColor, for: .normal)
        continueButton.setTitle("Tiếp tục", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        continueButton.center = CGPoint(x: view.center.x, y: view.frame.height - continueButton.frame.height - 24)
        continueButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton.defaultColor = UIColor.white
        continueButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        view.addSubview(continueButton)
        setContinueButton(enabled: false)
        
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = continueButton.center
        
        view.addSubview(activityView)
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passWordTextField.delegate = self
        
        userNameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passWordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
    }
    func setUpImage(){
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.clipsToBounds = true
        //tapToChangeProfileButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameTextField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        userNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passWordTextField.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        continueButton.center = CGPoint(x: view.center.x,
                                        y: view.frame.height - keyboardFrame.height - 16.0 - continueButton.frame.height / 2)
        activityView.center = continueButton.center
    }
    
    @objc func handleSignUp() {
        guard let username = userNameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let pass = passWordTextField.text else { return }
        guard let image = imageView.image else { return }
        
        setContinueButton(enabled: false)
        continueButton.setTitle("", for: .normal)
        activityView.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
                
                
                // 1. Upload the profile image to Firebase Storage
                
                self.uploadProfileImage(image) { url in
                    if url != nil {
                        print("start save !")
                        
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = username
                        changeRequest?.photoURL = url
                        
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                
                                self.saveProfile(username: username, profileImageURL: (url)!) { success in
                                    if success {
                                        self.dismiss(animated: true, completion: nil)
                                        print("ok pressed")
                                    } else {
                                        self.resetForm()
                                    }
                                }
                                
                            } else {
                                print("Error: \(error!.localizedDescription)")
                                self.resetForm()
                            }
                        }
                    } else {
                        self.resetForm()
                    }
                    
                }
                
            } else {
                self.resetForm()
            }
        }
    }
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping ((_ url: URL?)->())) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                storageRef.downloadURL(completion: {(url , error ) in
                    if url != nil {
                        completion(url)
                    }
                    else {
                        completion(nil)
                    }
                })
            } else {
                // Uh-oh, an error occurred!
                completion(nil)
            }
        }
        print("ok upload profileImage!")
 
    }
    
    func saveProfile(username: String, profileImageURL: URL, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var databaseRef : DatabaseReference!
            databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString
            ] as [String: Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        
        switch textField {
        case userNameTextField:
            userNameTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
            break
        case emailTextField:
            emailTextField.resignFirstResponder()
            passWordTextField.becomeFirstResponder()
            break
        case passWordTextField:
            handleSignUp()
            break
        default:
            break
        }
        return true
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let username = userNameTextField.text
        let email = emailTextField.text
        let password = passWordTextField.text
        let formFilled = username != nil && username != "" && email != nil && email != "" && password != nil && password != ""
        setContinueButton(enabled: formFilled)
    }
    
    func setContinueButton(enabled:Bool) {
        if enabled {
            continueButton.alpha = 1.0
            continueButton.isEnabled = true
        } else {
            continueButton.alpha = 0.5
            continueButton.isEnabled = false
        }
    }
    
    @objc func openImagePicker(_ sender:Any) {
        // Open Image Picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func resetForm() {
        let alert = UIAlertController(title: "Tên Email đã tồn tại. Hãy thử l !", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        setContinueButton(enabled: true)
        continueButton.setTitle("Tiếp tục", for: .normal)
        activityView.stopAnimating()
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        //if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
          //  self.imageView.image = pickedImage
        //}
        
        guard let possibleImage = info[.originalImage] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.imageView.image = possibleImage
        
        picker.dismiss(animated: true, completion: nil)
    }
}
