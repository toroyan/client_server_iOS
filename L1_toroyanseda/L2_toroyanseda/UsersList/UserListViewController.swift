//
//  UserListViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 08/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
   //var users = [String]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
   
    
    @IBOutlet weak var firstletterbuttons: FirstLetterButtons!
    @IBOutlet weak var tableView: UITableView!
    
    var indexUser=0
    
     var completionHandlers: [([String]) -> Void] = []
   var users = ["Anna Belkova", "Olga Nosova", "Suzan Black", "Andrew Simpson","Alina Zaitseva","David Green","Marina Novikova","Elen Mironova","Lily Adams","Kate Ivanova","Petr Petrov","Irina Slepakova"]
    
    var usersDict = [String:[String]]()
    var usersSectionTitle = [String]()
    var searchUser = [String]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let session = Session.shared
        let token = session.token
        
        let URL="https://api.vk.com/method/friends.get?access_token=\(token)&fields=photo_100,order=random&v=5.95"
        Alamofire.request(URL).responseObject { (response: DataResponse<UserResponse>) in
            let uResponse = response.result.value
            if let userItems = uResponse?.itemsResponse{
                for user in userItems {
                    if user.firstName != "DELETED" {
                        self.users.append(user.firstName!)
                    }
                    
                }
              
            }
              self.tableView.reloadData()
        }
       
     
        //----closure calling
        
       /* friendsLoading()  { [weak self] (users)
            in
            self?.users = users
            self?.tableView.reloadData()
        }*/

        
        createUsersDict()
        self.tableView.delegate = self
        //tableView.reloadData()
        firstletterbuttons.tableView = tableView
        let headerNib = UINib.init(nibName: "HeaderView", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderView")

    }

       // ----- Closure
        /* func friendsLoading(completionHandler: @escaping ([String]) -> Void) {
         let session = Session.shared
         let token = session.token
         
         let URL="https://api.vk.com/method/friends.get?access_token=\(token)&fields=photo_100,order=random&v=5.95"
         Alamofire.request(URL).responseObject { (response: DataResponse<UserResponse>) in
         let uResponse = response.result.value
         
         if let userItems = uResponse?.itemsResponse{
         for user in userItems {
         if user.firstName != "DELETED" {
            self.users.append(user.firstName! + " " + user.lastName!)
         }
         
         }
            completionHandler(self.users)
            self.completionHandlers = [completionHandler]
         }
         }
     
        */
        
    

    func numberOfSections(in tableView: UITableView) -> Int {
        if searching{
            return 1
        }
        else {
        return usersSectionTitle.count
        }
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) ->
    UIView? {
    
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
       
header.headerLabel.text = usersSectionTitle[section]
        header.headerLabel.frame = CGRect(x: 45, y: 5, width:100, height: 35)
        header.headerView.addSubview(header.headerLabel)

        return header
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searching{
    return searchUser.count
        }

            return 1
       
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserListViewCell
            let cornerRadius: CGFloat = 46
         cell.ShadowView.layer.shadowColor = UIColor.init(red: 0.2, green: 0.5, blue: 0.6, alpha: 1).cgColor
            cell.ShadowView.layer.shadowOpacity = 8
            cell.ShadowView.layer.shadowOffset = CGSize(width: 3.0, height: 7.0)
            cell.ShadowView.layer.shadowPath = UIBezierPath(roundedRect:
                cell.ShadowView.bounds, cornerRadius: cornerRadius).cgPath
            cell.userImageView.clipsToBounds = true
            cell.userImageView.layer.cornerRadius = cornerRadius
            cell.ShadowView.layer.cornerRadius = cornerRadius
     
            
            if searching{
                cell.userNameLabel.text = searchUser[indexPath.row]
                cell.userImageView.image = UIImage(named:searchUser[indexPath.row])
                return cell
            }
            
            else{
                let usersKey = usersSectionTitle[indexPath.section]
            if let usersValue = usersDict[usersKey]{
                
                cell.userNameLabel?.text = usersValue[indexPath.row]
             
                cell.userImageView?.image = UIImage(named:usersValue[indexPath.row])
           
                
                }
                

            }
          return cell
            
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //indexUser = indexPath.row
        
        let indexPath = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: indexPath!) as! UserListViewCell

        indexUser = users.firstIndex(of: (cell.userNameLabel?.text)!)!
       
        
        self.performSegue(withIdentifier: "showInfo", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as! UserPhotoGalleryViewController
        info.newImage = users[indexUser]
        //info.toPass = users[indexUser]
       

    }
    
    
    func createUsersDict(){
 
        for user in users{
          var arr = user.split(separator: " ")
            print(arr)
    let firstLetter = arr[1].index(arr[1].startIndex, offsetBy:1)
      
           let usersKey = String(arr[1][..<firstLetter])
            if var usersValue = self.usersDict[usersKey]{
                usersValue.append(user)
                self.usersDict[usersKey] = usersValue
            }
            else {
                self.usersDict[usersKey] = [user]
            }
              }
        self.usersSectionTitle = [String]((self.usersDict.keys)).sorted(by: { $0<$1})
        
}
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching = true
        searchBar.endEditing(true)
        tableView.reloadData()
    }
    
    
            func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       searchUser = users.filter({$0.lowercased().prefix(searchText.count)==searchText.lowercased()})
               
                if searchText != ""{
               
                searching = true
                tableView.reloadData()
                }
                else {
                    searching = false
                    tableView.reloadData()
                }
        }
   
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
 searching = false
        tableView.reloadData()
        
    }
    

 

}

