//
//  UserListViewCell.swift
//  L2_toroyanseda
//
//  Created by Seda on 08/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class UserListViewCell: UITableViewCell {

    @IBOutlet weak var ShadowView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /*override func prepareForReuse() {
        super.prepareForReuse()
        let cornerRadius: CGFloat = 46;        self.ShadowView.layer.shadowColor = UIColor.init(red: 0.2, green: 0.5, blue: 0.6, alpha: 1).cgColor
        self.ShadowView.layer.shadowOpacity = 8
        self.ShadowView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.ShadowView.layer.shadowPath = UIBezierPath(roundedRect:
            self.ShadowView.bounds, cornerRadius: cornerRadius).cgPath
    }*/

}
