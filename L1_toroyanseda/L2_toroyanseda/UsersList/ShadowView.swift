//
//  ShadowView.swift
//  L2_toroyanseda
//
//  Created by Seda on 11/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    @IBInspectable var HiddenShadow: Bool{
        get{
            return self.layer.masksToBounds
        }
        set{
            self.layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat{
        get{
            return self.layer.shadowRadius
        }
        set{
            self.layer.shadowRadius = newValue
        }
    }
    
    
   
 
}
