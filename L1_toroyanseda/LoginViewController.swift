//
//  LoginViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 04/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit
class Session{
    static let shared = Session()
    private init() {}
    var userId: Int = 0
    var token:String = ""
    
}
class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
   
    
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passLogError: UILabel!
    
    
    @IBOutlet weak var dot1Image: UIImageView!
   
    
    @IBOutlet weak var dot2Image: UIImageView!
    
    @IBOutlet weak var dot3Image: UIImageView!
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
     
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        let session = Session.shared
        session.userId = 12345
        session.token = "5defcgh90jkng"
    }


   
    // Появление клавиатуры
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // когда клавиатура изчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // уведомления о появлении и исчезновении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //исчезновение клавиатуры при клике по пустому месту
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
   //привязка segue при правильном заполнении
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if( loginField.text != "" &&  passwordField.text != ""){
            if(loginField.text=="abc" && passwordField.text == "123"){
                return true
            }
                
            else {
               passLogError.text = ""
                return false
            }
        }
            else{
            passLogError.text = "Fill in the login and password"
            passLogError.textColor = UIColor.red
           return false
        }
        
       
    }



    @IBAction func signInButton(_ sender: Any) {
        
        UIView.animate(withDuration: 1, delay:0.2,options:.repeat, animations: {
            self.dot1Image.alpha = 1
        })
        UIView.animate(withDuration: 1, delay: 0.4, options:.repeat,  animations: {
            self.dot2Image.alpha = 1
        })
        UIView.animate(withDuration: 1, delay: 0.6, options:.repeat, animations: {
           self.dot3Image.alpha = 1
        })
        guard loginField.text != "", passwordField.text != "" else{
            passLogError.text = "Fill in the login and password"
            passLogError.textColor = UIColor.red
            return
        }
            // появление alert при неправильном заполнении
             let messageAlert = UIAlertController(title: "Error", message: "Entered not right data", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            messageAlert.addAction(action)
            present(messageAlert,animated: true,completion: nil)
        
        
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        loginField.text=""
        passLogError.text=""
        passwordField.text=""
    }
  
}
