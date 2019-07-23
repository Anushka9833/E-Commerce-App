//
//  CollectionViewCell.swift
//  SampleApp1
//
//  Created by Anmol Kumar on 09/07/19.
//  Copyright © 2019 Anushka. All rights reserved.
//
protocol BrowseView: AnyObject{
    func reload(tag: Int)
    func minus(tag: Int)
}



import UIKit



class CollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet var iamgeview: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var numberOfLikes: UILabel!
    @IBOutlet var numberOfComments: UILabel!
    @IBOutlet var TrendingImage: UIImageView!
    @IBOutlet var TrendingLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var cartButton: UIButton!
    
    //MARK:- Variables declaration
    var ifIsLiked: Bool = false
    var ifIsInCart: Bool = false
    var price = 0.0
    var image = Data()
    var color: String = ""
    var num = 0.0
    var selectedButton = NSMutableIndexSet()
   
    var noOfLikes = Int()
    
    weak var delegate: BrowseView?
    
  //MARK:- likeButton pressed
    @IBAction func likeButton(_ sender: UIButton){
        
        if numberOfLikes.text == "0 likes"{
           
            delegate?.reload(tag:sender.tag)

        }
        else{
            delegate?.minus(tag: sender.tag)
        }
       

    }
    
  // MARK:-  add button pressed
    @IBAction func addToCart(_ sender: UIButton) {
        
            selectedButton.add(sender.tag)
            print(selectedButton)
        
    if DatabaseHelper.instance.search(name: productName.text!) == false{
            cartButton.setImage(#imageLiteral(resourceName: "favoriteditemenabled"), for: .normal)
            print(image)
            dict = ["name":productName.text!,"price":price,"image":image,"colorname":color,"color":color,"number":num] as [String : Any]
            num = 1
            DatabaseHelper.instance.save(object: dict)
            print("added")
        }
    else{
            return
        }
       
    }
    
    
  //MARK:-  awakeFromNib method
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberOfLikes.text! = String(noOfLikes)+" likes"
    }
   

}
