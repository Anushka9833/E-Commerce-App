//
//  HotCollectionViewCell.swift
//  SampleApp1
//
//  Created by Anmol Kumar on 09/07/19.
//  Copyright © 2019 Anushka. All rights reserved.
//

import UIKit
import  CoreImage

class HotCollectionViewCell: UICollectionViewCell {


//MARK: Outlets
    @IBOutlet var Label: UILabel!
    @IBOutlet var frontImage: UIImageView!
    @IBOutlet var backImage: UIImageView!
    
    
    var image = UIImage()
    
//MARK: awakeFromNiB
    override func awakeFromNib() {
        super.awakeFromNib()
        
     backImage.image = image
      
    }
   
  

    
}


