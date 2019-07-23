//
//  CartCollectionViewCell.swift
//  SampleApp1
//
//  Created by Anmol Kumar on 09/07/19.
//  Copyright © 2019 Anushka. All rights reserved.
//
protocol cart: AnyObject{
    func presentCart()
    
}

import UIKit


class CartCollectionViewCell: UICollectionViewCell {

    //Delegate for protocol cart
    weak var delegate: cart?
   
    
    //MARK: Outlets
    @IBOutlet var designableView: DesignableView!
    @IBOutlet var image: UIImageView?
    @IBOutlet var label: UILabel?
    @IBOutlet var priceLabel: UILabel?
    @IBOutlet var colorImage: DesignableView?
    @IBOutlet var colorLabel: UILabel?
    @IBOutlet var numberLabel: UILabel?
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var plusButton: UIButton!
    
    lazy var value = Double()
    var number = 1
    
    
    //Mark: minus button pressed
    @IBAction func minusButton(_ sender: UIButton) {
       
        if value > 1{
            
            value=value-1
            DatabaseHelper.instance.changeValueForCartItem(newVal: Double(value), id: label!.text!)
            self.delegate!.presentCart()
        }
            
        else if value == 1 {
            value = 0
            DatabaseHelper.instance.deleteData(Id: label!.text!)
            self.delegate?.presentCart()
        
        }
        
        else if value < 1{
            return
        }
        
    }
    
    //MARK: plus button pressed
    @IBAction func plusButton(_ sender: UIButton) {
        
        if value < 10{
            value=value+1
            DatabaseHelper.instance.changeValueForCartItem(newVal: Double(value), id: label!.text!)
            self.delegate!.presentCart()
        }
            
        else if value == 10 {
            print("max limit exceeded")
            return
        }
        
        
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberLabel?.text = String(value)
       }

    
}
