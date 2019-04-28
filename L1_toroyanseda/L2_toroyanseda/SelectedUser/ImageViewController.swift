//
//  ImageViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 08/04/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    var counting:Int = 250
    let checkedImage = UIImage(named: "heart_2")
   var unCheckedImage = UIImage(named: "heart_1")
    var index:Int = 0
   var isChecked:Bool = false
  
 var i = 0
    
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var image = UIImage()
    var imgArr = [UIImage]()
 
    var likesTitle = [250,190,150,100,450,600,100]
    var likesState = [0,   1,  0,  1,   1, 0,  0]
    var indexSelected = Int()
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        
     imgArr[index] = image
       imageView.image = image
        if likesState[index] == 0{
            likeButton.setImage(unCheckedImage, for: .normal)
            likeButton.setTitle(String(likesTitle[i]), for: .normal)
          
            
        }
        else {
            likeButton.setImage(checkedImage, for: .normal)
            likeButton.setTitle(String(likesTitle[i]), for: .normal)
     
            
        }
    
        imageView.isUserInteractionEnabled = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeImage(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        imageView.addGestureRecognizer(swipeLeft)
      
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(swipeImage(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        imageView.addGestureRecognizer(swipeRight)
      likeButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
        
    
        
        let zoomImage = UIPinchGestureRecognizer(target: self, action: #selector(zoomInOutImage(sender:)))
        imageView.addGestureRecognizer(zoomImage)
      
    }
    
       @objc func buttonAction(sender:UIButton){
      isChecked = !isChecked
            if isChecked == true{
                if  likesState[index] == 1{
                    UIView.transition(with:sender, duration: 0.5, options: .transitionFlipFromTop, animations: {
                        sender.setImage(self.unCheckedImage, for: .normal)
                        sender.setTitle(String(self.likesTitle[self.index] - 1), for: .normal)
                    })
                    likesState[index] = 0
                  likesTitle[index] = likesTitle[index] - 1
                }
                    
             else {
                     UIView.transition(with:sender, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                        sender.setImage(self.checkedImage, for: .normal)
                        sender.setTitle(String(self.likesTitle[self.index] + 1), for: .normal)
                     })
                    likesState[index] = 1
                    likesTitle[index] = likesTitle[index] + 1
                }
        }
            else {
                if  likesState[index] == 0{
                    UIView.transition(with:sender, duration: 0.5, options: .transitionFlipFromTop, animations: {
                        sender.setImage(self.checkedImage, for: .normal)
                        sender.setTitle(String(self.likesTitle[self.index] + 1 ), for: .normal)
                    })
                    likesState[index] = 1
                    likesTitle[index] = likesTitle[index] + 1
                }
               else {
                    UIView.transition(with:sender, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                        sender.setImage(self.unCheckedImage, for: .normal)
                        sender.setTitle(String(self.likesTitle[self.index] - 1), for: .normal)
                    })
                   likesState[index] = 0
                   likesTitle[index] = likesTitle[index] - 1
                    
                }
               
               
            
        }
                
                
            }
    

    
    @objc func zoomInOutImage(sender:UIPinchGestureRecognizer){
        guard sender.view != nil else {
            return
        }
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
        }
    }
    
    
    @objc func swipeImage(_ sender: UISwipeGestureRecognizer) {
       
    // i = index
        
        switch sender.direction{
    
        case .left:
            if (index == imgArr.count-1) && (i == likesState.count-1){
                index = 0
                i = 0
            }
            else{
                index = index+1
                i = i + 1
            }
            
            leftTransition()
         imageView.image = imgArr[index]
         
            if likesState[i] == 0 {
                likeButton.setImage(unCheckedImage, for: .normal)
                likeButton.setTitle(String(likesTitle[i]), for: .normal)
        
            }
            else {
                
                likeButton.setImage(checkedImage, for: .normal)
                likeButton.setTitle(String(likesTitle[i]), for: .normal)
            
            }
       
      
        case .right:
        
            if (index == 0) && (i == 0){
                index = imgArr.count-1
                i = likesState.count-1
            }
            else{
                index = index-1
                i = i-1
            }
            
            rightTransition()
            imageView.image = imgArr[index]
            if likesState[i] == 0 {
               //   likeButton.tag = i
                likeButton.setImage(unCheckedImage, for: .normal)
                likeButton.setTitle(String(likesTitle[i]), for: .normal)
              // likeButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
                
            }
            else {
        //likeButton.tag = i
                likeButton.setImage(checkedImage, for: .normal)
                likeButton.setTitle(String(likesTitle[i]), for: .normal)
             //  likeButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
                
            }
           //  likeButton.tag = i
          //  likeButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            
            
            
        default: break
        }
        
    }
    
    
    func leftTransition(){
        
        let leftTransition = CATransition()
        leftTransition.type = CATransitionType.push
        leftTransition.subtype = CATransitionSubtype.fromRight
        leftTransition.duration = 0.35
        leftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        leftTransition.fillMode = CAMediaTimingFillMode.both
        imageView.layer.add(leftTransition, forKey: "leftTransition")
        imageView.transform = CGAffineTransform(scaleX:0.92, y: 0.92)
        
      
        
    }
    func rightTransition(){
        
        let rightTransition = CATransition()
        rightTransition.type = CATransitionType.push
        rightTransition.subtype = CATransitionSubtype.fromLeft
        rightTransition.duration = 0.35
        rightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        rightTransition.fillMode = CAMediaTimingFillMode.both
        imageView.layer.add(rightTransition, forKey: "rightTransition")
        imageView.transform = CGAffineTransform(scaleX:0.92, y: 0.92)
        
        
        
    }
    
    
    
    
  /* func createLikeButton(){
    
           var button = UIButton()
            button.frame = CGRect (x: 200, y: 730, width: 16, height: 16)
     button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
     if(isChecked == true){
       var  unCheckedImage = UIImage(named:"heart_2")
          button.setImage(unCheckedImage, for: .normal)
     }
        else {
               var  unCheckedImage = UIImage(named:"heart_1")
          button.setImage(unCheckedImage, for: .normal)
        }
        
    
    view.addSubview(button)
    }
    */


     /*   var i = 0

            var button = UIButton()
            button.frame = CGRect (x: 200, y: 730, width: 16, height: 16)
         //   button.tag = i
            if(isChecked == true){
                button.setImage(checkedImage, for: .normal)}
            else{
                button.setImage(unCheckedImage, for: .normal)
            }
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
            view.addSubview(button)
            i = i+1*/
        }
        
        
        


   
    

