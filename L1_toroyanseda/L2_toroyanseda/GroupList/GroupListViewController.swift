//
//  GroupListViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 09/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class GroupListViewController: UIViewController {
    var indexUser=0
   var groups = ["Painting", "Dancing", "Music", "Theatre"]
 
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        
    }
   
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if let info = segue.source as? NewGroupViewController{
            guard let indexPath = info.tableView.indexPathForSelectedRow else{
                return
            }
               let newMember = info.newGroup[indexPath.section]
            
                groups.append(newMember)
                tableView.reloadData()
                
            }
        
    
    }
}

   


    extension GroupListViewController : UITableViewDataSource {
       
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return groups.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupListTableViewCell
            cell.groupNameLabel.text = groups[indexPath.row]
            cell.groupImageView.image = UIImage(named:groups[indexPath.row])
            
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

    


