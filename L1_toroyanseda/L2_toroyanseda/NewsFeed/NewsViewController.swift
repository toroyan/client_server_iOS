//
//  NewsViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 26/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
tableView.dataSource = self
  tableView.delegate = self
        let footerNib = UINib.init(nibName: "FooterView", bundle: Bundle.main)
        tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: "FooterView")
        tableView.backgroundColor = UIColor.clear
        
    }
    

    let users=["Anna Belkova", "Olga Nosova", "Suzan Black", "Andrew Simpson","Alina Zaitseva","David Green","Marina Novikova","Elen Mironova","Lily Adams","Kate Ivanova","Petr Petrov","Irina Slepakova"]
    
    let timeText = ["Yesterday at 23:30", "Today at 08:00","Monday at 16:00", "Today at 08:00","Yesterday at 18:30", "Thursday at 08:00","Yesterday at 23:30", "Tuesday at 08:00","Today at 08:00","Yesterday at 18:30", "Thursday at 08:00","Yesterday at 23:30"]
    
    let typedText = ["The most beautiful tower ))", "I haven`t been in Venice since 2012","The tallest palm that I have ever seen!", "I`m in the fairy-tail","It`s never too late to learn drawing","These girls adore chatting", "Our ballet Studio opens a set of groups","The most beautiful tower ))", "I haven`t been in Venice since 2012","The tallest palm that I have ever seen!","It`s never too late to learn drawing", "These girls adore chatting"]
    
    
    let newsImages = ["tower","venice","palm","xtree","Painting","Chatting","Dancing","tower","venice","palm","Painting","Chatting"]
    

    
    func numberOfSections(in tableView: UITableView) -> Int {

    return users.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
       
        
        
            cell.userName.text = users[indexPath.section]
            cell.userImageView.image = UIImage(named: users[indexPath.section])
            let cornerRadius: CGFloat = 42.5
            cell.userImageView.clipsToBounds = true
            cell.userImageView.layer.cornerRadius = cornerRadius
            
            cell.timeText.text = timeText[indexPath.section]
            cell.typedText.text = typedText[indexPath.section]
          
            cell.NewsImageView.image = UIImage(named:newsImages[indexPath.section])
       
        
      
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
      let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterView") as! FooterView
     
    footer.addSubview(footer.likeButton)
    footer.addSubview(footer.shareButton)
    footer.addSubview(footer.commentButton)
        footer.addSubview(footer.lineView)

        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    
}
