//
//  ProductDetailsViewController.swift
//  SampleApp1
//
//  Created by Anmol Kumar on 10/07/19.
//  Copyright © 2019 Anushka. All rights reserved.
//


import UIKit

//global dictonary for passing data into Core Data Model
var dict = ["name":String.self,"price":Double.self,"image":NSData.self,"number":Double.self,"colorname":String.self,"color":String.self] as [String : Any]


class ProductDetailsViewController: UIViewController {
//Array of images in collection view : (represents people who liked the product)
    let Array = [UIImage(named: "1"), UIImage(named: "2") , UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "6"),UIImage(named: "7"), UIImage(named: "5") , UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10")]

//variables declaration
    var label = ""
    var image = UIImage()
    var price = 0.0
    var colorA = UIColor()
    var colorName = ""
    var popImage = UIImage()
    var popLabel = ""
    var popPrice = 0.0
    var num = 1.0
    var noOfLikes = Int()
    var timer = Timer()
//MARK: IBOutlets
    @IBOutlet var popUp: UIView!
//Add to cart button
    @IBOutlet var cartbutton: DesignableButton!
    
    @IBOutlet var viewCart: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelPrice: UILabel!
    @IBOutlet var numberOfLikes: UILabel!
    
    @IBOutlet var cview: UICollectionView!
    
 //buttons on top each side for liking and adding the product to cart
    @IBOutlet var likebutton: UIButton!
    @IBOutlet var addTocart: UIButton!
    
// popup outlets
    @IBOutlet var PopUpBottom: NSLayoutConstraint!
    @IBOutlet var popUpPrice: UILabel!
    @IBOutlet var popUpLabel: UILabel!
    @IBOutlet var popUpImage: UIImageView!
    @IBOutlet var popUpNumber: DesignableButton!

//MARK: like button pressed
    @IBAction func likeButton(_ sender: UIButton) {
        if numberOfLikes.text == "1 likes"{
            likebutton.setImage(#imageLiteral(resourceName: "heartitem"), for: .normal)
            numberOfLikes.text = "0 likes"
            
           
           
            
        }
        else{
            likebutton.setImage(#imageLiteral(resourceName: "heartitemenabled"), for: .normal)
             numberOfLikes.text = "1 likes"
            
           
        }
        print(sender.tag)

    }
    
    
//MARK: cart button pressed
    @IBAction func addToCart(_ sender: UIButton) {
        
        let image1 = image.pngData()
        dict = ["name":label,"price":price,"image":image1 as Any,"colorname":colorName,"color":colorName,"number":num] as [String : Any]
        
        if DatabaseHelper.instance.search(name: label) == false{
            num+=1
            DatabaseHelper.instance.save(object: dict )
            addTocart.setImage(#imageLiteral(resourceName: "favoriteditemenabled"), for: .normal)
            cartbutton.backgroundColor = .gray
            cartbutton.setImage(#imageLiteral(resourceName: "check_icon"), for: .normal)
            cartbutton.setTitle("ADDED TO CART", for: .normal)
            cartbutton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 150,bottom: 0,right: 0)
            UIView.animate(withDuration: 0.5) {
                self.PopUpBottom.constant = 0
            }
            
            
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(showCart), userInfo: nil, repeats: false)
            let num = DatabaseHelper.instance.getData()
            popUpNumber.setTitle(String(num.count), for: .normal)
        }
        else{
            print("can't save data")
        }
       
    }
    
    @objc func showCart(){
        print("cart")
        UIView.animate(withDuration: 0.5) {
            self.PopUpBottom.constant = -100
        }
     
    }
   
    
    //MARK: View Cart button pressed in popUpView
    @IBAction func viewCartButton(_ sender: UIButton) {

        let storyb = UIStoryboard(name: "Cart", bundle: nil)
        let vc = storyb.instantiateViewController(withIdentifier: "cvc") as! CartViewController
        self.navigationController?.pushViewController(vc, animated: true)
     
        
        
            }
    
    
//MARK: ADD TO CART PRESSED
    @IBAction func cartButton(_ sender: UIButton) {

        let image1 = image.pngData()
        dict = ["name":label,"price":price,"image":image1 as Any,"colorname":colorName,"color":colorName,"number":num] as [String : Any]
        
    if sender.backgroundColor != .gray {
           if DatabaseHelper.instance.search(name: label) == false{
                num+=1
                DatabaseHelper.instance.save(object: dict )
                inCart()
            
            UIView.animate(withDuration: 0.5) {
                self.PopUpBottom.constant = 0
            }
            
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(showCart), userInfo: nil, repeats: false)
            }
            else{
                print("can't save data")
            }
    
        
        }
            

        
    }
 
    func inCart(){
        cartbutton.backgroundColor = .gray
        addTocart.setImage(#imageLiteral(resourceName: "favoriteditemenabled"), for: .normal)
        cartbutton.setTitle("ADDED TO CART", for: .normal)
        cartbutton.imageEdgeInsets = UIEdgeInsets(top: 0,left: 150,bottom: 0,right: 0)
        cartbutton.setImage(#imageLiteral(resourceName: "check_icon"), for: .normal)
        let num = DatabaseHelper.instance.getData()
        popUpNumber.setTitle(String(num.count), for: .normal)

    }
    
    
    @IBAction func popUpDismiss(_ sender: UIButton) {
        PopUpBottom.constant = -100
    }
    
    
    //MARK: Back button pressed
    @IBAction func backButton(_ sender: UIBarButtonItem) {
 
        self.navigationController?.popViewController(animated: true)
    
    }
    
   
   
    //MARK: viewdidload()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        labelName.text = label
        imageView.image = image
        labelPrice.text = "$"+String(price)
        popUpImage.image = popImage
        popUpLabel.text = popLabel
        popUpPrice.text = "$"+String(popPrice)
        numberOfLikes.text = String(noOfLikes)+" likes"
      
        

        
    }
    
  
    
    //MARK: viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
      
        if DatabaseHelper.instance.search(name: label) == true{
            inCart()
        }
        else{
            addTocart.setImage(#imageLiteral(resourceName: "favoriteditem"), for: .normal)
            cartbutton.backgroundColor = .red
            cartbutton.setImage(nil, for: .normal)
            cartbutton.setTitle("ADD TO CART", for: .normal)
        }
        
        if numberOfLikes.text == "1 likes"{
           likebutton.setImage(#imageLiteral(resourceName: "heartitemenabled"), for: .normal)
        }
        else{
            likebutton.setImage(#imageLiteral(resourceName: "heartitem"), for: .normal)
        }
       popUp.isUserInteractionEnabled = true
      }
 
    
    
   }



//MARK: collectionView methods:

extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout , UICollectionViewDataSource , UICollectionViewDelegate{
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return Array.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = cview.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! ProductCviewCell
            cell.cImage.image = Array[indexPath.row]
            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: 68, height: 50)
        }
    }
   
    


