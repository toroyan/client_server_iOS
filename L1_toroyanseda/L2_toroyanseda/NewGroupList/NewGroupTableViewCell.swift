//
//  NewGroupTableViewCell.swift
//  L2_toroyanseda
//
//  Created by Seda on 09/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class NewGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var newGroupLabel: UILabel!
    @IBOutlet weak var newGroupImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
