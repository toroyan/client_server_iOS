//
//  NewGroupViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 09/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class NewGroupViewController:
UIViewController {




    var indexUser=0
    let newGroup=["Sport","Chatting","Photography"]
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
   
}
extension NewGroupViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return newGroup.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newGroupCell", for: indexPath) as! NewGroupTableViewCell
        cell.newGroupLabel.text = newGroup[indexPath.section]
        cell.newGroupImageView.image = UIImage(named:newGroup[indexPath.section])
        let cornerRadius: CGFloat = 46
        
        cell.newGroupImageView.clipsToBounds = true
        cell.newGroupImageView.layer.cornerRadius = cornerRadius
        return cell
    }
   
    }


    

    

    

   


