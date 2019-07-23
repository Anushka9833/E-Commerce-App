//
//  BrowseScreenViewController.swift
//  SampleApp1
//
//  Created by Anmol Kumar on 09/07/19.
//  Copyright © 2019 Anushka. All rights reserved.
//

import UIKit


class BrowseScreenViewController: UIViewController , BrowseView{
    
    //MARK: Data arrays
    var photoArray = [UIImage(named: "item1"),UIImage(named: "item3"),UIImage(named: "item4"),UIImage(named: "item5"),UIImage(named: "item6"),UIImage(named: "item7"),UIImage(named: "item8"),UIImage(named: "item9"),UIImage(named: "item10"),UIImage(named: "item11"),UIImage(named: "item12"),UIImage(named: "item13"),UIImage(named: "one"),UIImage(named: "two"),UIImage(named: "three"),UIImage(named: "four"),UIImage(named: "five")]
    let name = ["iPad Pro (128 GB)","Occulus Rift","FitBit Charge","Garmin vívosmart 4 Band","Samsung Watch","Wemo Smart Plug","Echo(2 G)-Speaker ","Sony  Headphones","OontZ Angle 3G-Speaker","Yootech Wireless Charger","amFilm Screen Protector ","Garmin Drive GPS Navigator ","Apple Watch","Games","iPhone","Origins","Samsung galaxy S10"]
    let priceA = [949.00,599.00,199.00,109.95,299.00,27.97 ,69.99,348.00,25.99,12.99,6.99 ,122.00,200.15,80.00,898.00,1200.00,500.00]
    let photoColor : [UIColor] = [ .gray , .black , .blue , .black, .black , .white , .darkGray , .black ,.black , .black , .green , .black ,.red , .black , .lightGray , .black , .gray]
    let photocolorName = ["Gray", "Black" , "Blue" , "Black", "Black" , "White" , "Gray" , "Black" ,"Black" , "Black" , "Green" , "Black","Red","Black","Gray","Black","Gray"]
   
    var likes = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    var num = 1.0

    @IBOutlet var cview: UICollectionView!
    
    //MARK: viewdidload()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cview.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        cview.reloadData()
       
    }
    
    
    func reload(tag: Int) {
        print("plus likes ")
        likes[tag] = 1
        cview.reloadData()
    }
    
    func minus(tag: Int){
        print("minus likes")
        likes[tag] = 0
        cview.reloadData()
    }

    
}


//MARK: Extension : 
//MARK: collection view methods


extension BrowseScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.delegate = self
        cell.iamgeview.image = photoArray[indexPath.row]
        cell.productName.text = name[indexPath.row]
        cell.price = priceA[indexPath.row]
        cell.productPrice.text = "$"+String(priceA[indexPath.row])
        cell.image = (photoArray[indexPath.row]?.pngData())!
        cell.color = photocolorName[indexPath.row]
        cell.num = num
        cell.cartButton.tag = indexPath.row
        cell.likeButton.tag = indexPath.row
        cell.numberOfLikes.text = String(likes[indexPath.row])+" likes"
      
        
        if cell.numberOfLikes.text == "1 likes"{
            cell.likeButton.setImage(#imageLiteral(resourceName: "heartitemenabled"), for: .normal)
        }
        else{
            cell.likeButton.setImage(#imageLiteral(resourceName: "heartitem"), for: .normal)
        }
     
        if DatabaseHelper.instance.search(name: cell.productName.text!) == true{
            cell.cartButton.setImage(#imageLiteral(resourceName: "favoriteditemenabled"), for: .normal)
        }else{
            cell.cartButton.setImage(#imageLiteral(resourceName: "favoriteditem"), for: .normal)
        }
        
        
        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyb = UIStoryboard(name: "ProductDetails", bundle: nil)
        let vc = storyb.instantiateViewController(withIdentifier: "pvc") as! ProductDetailsViewController
        
        vc.image = photoArray[indexPath.row]!
        vc.label = name[indexPath.row]
        vc.price = priceA[indexPath.row]
        vc.colorA = photoColor[indexPath.row]
        vc.colorName = photocolorName[indexPath.row]
        vc.popImage = photoArray[indexPath.row]!
        vc.popPrice = priceA[indexPath.row]
        vc.popLabel = name[indexPath.row]
        vc.noOfLikes = likes[indexPath.row]
  
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 315)
    }
    
    
    
}


