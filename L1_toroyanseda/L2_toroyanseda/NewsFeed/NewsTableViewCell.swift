//
//  NewsTableViewCell.swift
//  L2_toroyanseda
//
//  Created by Seda on 26/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    
    @IBOutlet weak var timeText: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var typedText: UITextView!
    
   
    @IBOutlet weak var NewsImageView: UIImageView!
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        NewsImageView?.image = nil
    }
}
