//
//  LoginViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 04/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
import AlamofireObjectMapper
import SwiftKeychainWrapper
class Session{
    static let shared = Session()
    private init() {}
    var userId: Int = 0
    var token:String = ""
    
}
class LoginViewController: UIViewController, WKNavigationDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
   
    
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passLogError: UILabel!
    
    
    @IBOutlet weak var dot1Image: UIImageView!
   
    
    @IBOutlet weak var dot2Image: UIImageView!
    
    @IBOutlet weak var dot3Image: UIImageView!
   
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
     // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
     
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
  
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6964680"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.95"),
            URLQueryItem(name: "revoke", value: "1")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)

    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
   
        // Сохранение токена в  KeyChain
       let session = Session.shared
       var tokenData = KeychainWrapper.standard.string(forKey: "token")
        
        if tokenData == nil{
            guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
                decisionHandler(.allow)
                return
            }
            
            let params = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce([String: String]()) { result, param in
                    var dict = result
                    let key = param[0]
                    let value = param[1]
                    dict[key] = value
                    return dict
            }
            
            KeychainWrapper.standard.set(params["access_token"]!, forKey: "token")
            tokenData = KeychainWrapper.standard.string(forKey: "token")
            print("setting new token")
         
        }
           session.token = tokenData!
        print("session.token",session.token)
           // KeychainWrapper.standard.removeAllKeys()
        
        
        
        // Get Friends
        let URL="https://api.vk.com/method/friends.get?access_token=\(session.token)&fields=photo_100,order=random&v=5.95"
        Alamofire.request(URL).responseObject { (response: DataResponse<UserResponse>) in
            
            let uResponse = response.result.value
            if let userItems = uResponse?.itemsResponse {
                for users in userItems {
                //  print("Name:" + users.firstName! + " Surname:" + users.lastName! + " Photo:" + users.photo!)
                 
            // Сохранение имени пользователя в UserDefaults
             UserDefaults.standard.set(users.firstName, forKey: "userName")
             var usersName = UserDefaults.standard.string(forKey: "userName")
             print("Saved user Name from UserDefaults", usersName)
                }
            }
        }
     
        
        // Get Groups
        let GroupURL="https://api.vk.com/method/groups.get?access_token=\(session.token)&fields=photo_100,name&extended=1&v=5.95"
        Alamofire.request(GroupURL).responseObject { (response: DataResponse<GroupsResponse>) in
            
            let gResponse = response.result.value
            
            if let groupItems = gResponse?.itemsResponse {
                for groups in groupItems {
                   // print("Name:" + groups.name! + " Photo:" + groups.photo!)
                }
            }
        }
    
        
        // Get Photos
       let PhotoURL="https://api.vk.com/method/photos.getUserPhotos?access_token=\(session.token)&owner_id=-1&extended=0&v=5.95"
        Alamofire.request(PhotoURL).responseObject { (response: DataResponse<PhotosResponse>) in
            let pResponse = response.result.value
            if let photoItems = pResponse?.photosResponse {
                for photos in photoItems {
                    if photos.type == "m"{ // выводим только мидиум размеры
                   // print("Photo:" + photos.url!)
                    }
                }
            }
        }
   
  
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainStoryBoard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
      
        self.present(mainVC, animated: true)
        
        decisionHandler(.cancel)
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
