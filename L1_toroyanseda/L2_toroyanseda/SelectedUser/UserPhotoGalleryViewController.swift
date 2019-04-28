//
//  UserPhotoGalleryViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 04/04/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class UserPhotoGalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    var newImage:String!
    var indexUser = 0
    @IBOutlet weak var collectionView: UICollectionView!
    var img = [UIImage(named: ""),
               UIImage(named: "xtree"),
               UIImage(named: "tower"),
               UIImage(named: "palm"),
               UIImage(named: "venice"),
               UIImage(named: "palm"),
               UIImage(named: "venice")]
    
 //   var like = [UIButton.setImage()]
    override func viewDidLoad() {
        super.viewDidLoad()
img[0] = UIImage(named: newImage)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath)as! UsersphotoGalleryCollectionViewCell
        
      cell.imageView.image = img[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
   
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let imgVC = mainStoryBoard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        imgVC.image = img[indexPath.row]!
        imgVC.index = indexPath.row
        imgVC.i = indexPath.row
        imgVC.imgArr = img as! [UIImage]
        self.navigationController?.pushViewController(imgVC, animated: true)
    }
    
}
