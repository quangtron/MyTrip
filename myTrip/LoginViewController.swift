//
//  LoginViewController.swift
//  myTrip
//
//  Created by Le Thanh Thanh Toai on 12/8/18.
//  Copyright © 2018 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    
    var continueButton: DesigbButton!
    var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpContinueButton()
        
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
        continueButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        continueButton.alpha = 0.5
        view.addSubview(continueButton)
        setContinueButton(enabled: false)
        
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = continueButton.center
        
        view.addSubview(activityView)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @objc func handleSignIn() {
        guard let email = emailTextField.text else { return }
        guard let pass = passwordTextField.text else { return }
        
        setContinueButton(enabled: false)
        continueButton.setTitle("", for: .normal)
        activityView.startAnimating()
        
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
            } else {
                print("Error logging in: \(error!.localizedDescription)")
                
                self.resetForm()
            }
        }
        
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setContinueButton(enabled: formFilled)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        
        switch textField {
        case emailTextField:
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            break
        case passwordTextField:
            handleSignIn()
            break
        default:
            break
        }
        return true
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
    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        continueButton.center = CGPoint(x: view.center.x,
                                        y: view.frame.height - keyboardFrame.height - 16.0 - continueButton.frame.height / 2)
        activityView.center = continueButton.center
    }
    
    func resetForm() {
        let alert = UIAlertController(title: "Email hoặc mật khẩu của bạn không chính xác!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        setContinueButton(enabled: true)
        continueButton.setTitle("Tiếp tục", for: .normal)
        activityView.stopAnimating()
    }
}

