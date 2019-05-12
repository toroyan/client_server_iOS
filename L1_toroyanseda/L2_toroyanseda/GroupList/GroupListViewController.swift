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


class GroupListViewController: UIViewController {
    var indexUser=0
    var groups = ["Painting", "Dancing", "Music", "Theatre"]
    var groupsL = [String]()
    var gImages = [String]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
      //  groupsLoading()
        let session = Session.shared
        let token = session.token
        
            let GroupURL="https://api.vk.com/method/groups.get?access_token=\(token)&fields=photo_100,name&extended=1&v=5.95"
            Alamofire.request(GroupURL).responseObject { (response: DataResponse<GroupsResponse>) in
                
                let gResponse = response.result.value
               
                if let groupItems = gResponse?.itemsResponse {
                    for groups in groupItems {
                        self.groupsL.append(groups.name!)
                        self.gImages.append(groups.photo!)
                        //  print("Name:" + groups.name! + " Photo:" + groups.photo!)
                    }
                }
           
                self.tableView.reloadData()
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
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupListTableViewCell
            //print("fff", groupsL)
            cell.groupNameLabel.text = groupsL[indexPath.row]
           // cell.groupImageView.image = UIImage(named:groups[indexPath.row])
            if let imageURL = gImages[indexPath.row] as? String {
                Alamofire.request(imageURL).responseImage(completionHandler: { (response) in
                    if let image = response.result.value{
                        DispatchQueue.main.async {
                            cell.groupImageView.image = image
                        }
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

    


