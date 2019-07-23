//
//  CartViewController.swift
//  SampleApp1
//
//  Created by Anmol Kumar on 09/07/19.
//  Copyright © 2019 Anushka. All rights reserved.
//

import UIKit
var text = ""

class CartViewController: UIViewController  {
  
    //Mark: outlets
    @IBOutlet var subTotal: UILabel!
    @IBOutlet var taxes: UILabel!
    @IBOutlet var total: UILabel!
    @IBOutlet var cview: UICollectionView!
    
    
    var cartItem = [CartItem]()
    var id = ""
    
    //MARK: viewWillLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        cview.reloadData()
        
    }
    
   


    //MARK: viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
    
        cview.register(UINib(nibName: "CartCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell2")
               presentCart()
        
    
    }
    
    //MARK: Function to update price and reload data in view controller
    func presentCart(){
        cview.reloadData()
        let t = DatabaseHelper.instance.getPrice()
        print(t)
        subTotal.text = "$"+String(format: "%0.2f", t)
        taxes.text = "$"+String(format: "%0.2f",(0.01*t))
        total.text = "$"+String(format: "%0.2f", 0.01*t+t)
        cartItem = DatabaseHelper.instance.getData()
        cview.reloadData()
    }
    

}


//MARK: Extension :
//MARK: CollectionView Methods
extension CartViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,cart{
 
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cartItem.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cview.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CartCollectionViewCell
        cell.delegate = self
        
        cell.label!.text = cartItem[indexPath.row].name
        cell.priceLabel!.text = "$"+String(cartItem[indexPath.row].price)
        cell.colorLabel!.text = cartItem[indexPath.row].colorName
        cell.minusButton.tag = indexPath.row
        cell.numberLabel!.text = String(Int(cartItem[indexPath.row].number))
        cell.value = DatabaseHelper.instance.retrieveNumberOfitems(id: cartItem[indexPath.row].name!)
        cell.colorImage!.backgroundColor = UIColor(named: cartItem[indexPath.row].color ?? "Black")
        cell.image!.image = UIImage(data:cartItem[indexPath.row].image!)
        
        return cell
    }
    
   

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/3)
    }

  
}
