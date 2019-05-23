//
//  GroupListViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 09/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireImage
import SwiftKeychainWrapper
import Foundation
import RealmSwift

class Rgroups: Object {
   // @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var gUrl = ""
    }

var groupsName: [Any] = []



class GroupListViewController: UIViewController {
    var indexUser=0
    var groups = ["Painting", "Dancing", "Music", "Theatre"]
    var groupsL = [String]()
    var gImages = [String]()
    var userName = [String]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self as! UITableViewDataSource 
    
        let session = Session.shared
      
     
            let GroupURL="https://api.vk.com/method/groups.get?access_token=\(session.token)&fields=photo_100,name&extended=1&v=5.95"
        
            Alamofire.request(GroupURL).responseObject { (response: DataResponse<GroupsResponse>) in
                
                let gResponse = response.result.value
                if let groupItems = gResponse?.itemsResponse {
                    for groups in groupItems {
                    
                        do {
                            let realm = try Realm()
                            realm.beginWrite()
                            let newRgroups = Rgroups()
                            newRgroups.name = groups.name!
                            newRgroups.gUrl = groups.photo!
                            realm.add(newRgroups)
                            try realm.commitWrite()
                            
                        }
                        catch{
                            print(error)
                        }
                        
                    }
                 
                }
            self.tableView.reloadData()
                
            }
       loadingData()
        tableView.reloadData()

        let realm = try! Realm()
        print(realm.configuration.fileURL)
    
        }
    
    
    func loadingData(){
        do{
           
            let realm = try! Realm()
            var groupsName  = realm.objects(Rgroups.self)
            for group in groupsName{
                groupsL.append(group.name)
                gImages.append(group.gUrl)
            }
        
        }
           
        
        catch{
            print("error", error)
        }
    }
    
   @IBAction func addGroup(segue: UIStoryboardSegue) {
        if let info = segue.source as? NewGroupViewController{
            guard let indexPath = info.tableView.indexPathForSelectedRow else{
                return
            }
               let newMember = info.newGroup[indexPath.section]
            
              //  groups.append(newMember)
                tableView.reloadData()
                
            }
    }
}

    extension GroupListViewController : UITableViewDataSource {
       
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return groupsL.count
         //   return 30
       
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupListTableViewCell
          
            cell.groupNameLabel.text = groupsL[indexPath.row]
            
           if let imageURL = gImages[indexPath.row] as? String {
                Alamofire.request(imageURL).responseImage(completionHandler: { (response) in
                    if let image = response.result.value{
                            cell.groupImageView.image = image
                    }
                })
            }

            let cornerRadius: CGFloat = 46
            cell.groupImageView.clipsToBounds = true
            cell.groupImageView.layer.cornerRadius = cornerRadius
            
            
            return cell
        }
   
         func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
            
              groups.remove(at: indexPath.row)
        
                tableView.deleteRows(at: [indexPath], with:.fade)
               
            }
        }

        
        
        
    }

    


