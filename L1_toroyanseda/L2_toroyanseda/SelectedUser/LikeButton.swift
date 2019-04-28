//
//  LikeButton.swift
//  L2_toroyanseda
//
//  Created by Seda on 12/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class LikeButton: UIButton {

   
    var counting:Int = 250
    let checkedImage = UIImage(named: "heart_2")
    let unCheckedImage = UIImage(named: "heart_1")
    
    @IBInspectable var isChecked: Bool = false{
        didSet{
            self.updateImage()
          
            
   
            
    }
    }
    
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(LikeButton.buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.updateImage()
    
        
    }
    
    
    func updateImage() {
        if isChecked == true{
            counting=counting+1
            self.setImage(checkedImage, for: [])
            UIView.transition(with:self, duration: 0.5, options: .transitionFlipFromTop, animations: {
              self.self.setTitle(" "+String(self.counting), for: [])
            })
           
           
        }else{
            if counting != 250  {counting = counting-1}
            self.setImage(unCheckedImage, for: [])
            UIView.transition(with:self, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.self.setTitle(" "+String(self.counting), for: [])
            })
            
        }
        
    }
    
    @objc func buttonClicked(sender:UIButton) {
        if(sender == self){
            isChecked = !isChecked
        }
    }
    
    
    
 
}

    


