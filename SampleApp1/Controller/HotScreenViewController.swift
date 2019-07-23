//
//  HotScreenViewController.swift
//  SampleApp1
//
//  Created by Anmol Kumar on 09/07/19.
//  Copyright © 2019 Anushka. All rights reserved.
//

import UIKit
import SpriteKit

class HotScreenViewController: UIViewController{
   
    //  Outlet fror collectionview
    @IBOutlet var cview: UICollectionView!
 
    
    //MARK: Data arrays :
    let parray = [UIImage(named: "one") , UIImage(named: "two") ,UIImage(named: "three") , UIImage(named: "four") ,UIImage(named: "five") , UIImage(named: "item6" )]
    let backArray = [UIImage(named: "one") , UIImage(named: "two") ,UIImage(named: "three"), UIImage(named: "four") ,UIImage(named: "five"), UIImage(named: "six") ]
    let darray = ["Apple Watch","Games","iPhone","Origins","Samsung Galaxy S10","Samsung Watch"]
    let price = [200.15,80.00,898.00,1200.00,500.00,250.00]
    let color = ["Black","Red","Black","Gray","Black","Gray"]
    
    //CONTEXT declaration for CoreImage Filter Gaussian Blur
    let context = CIContext(options:nil)
    
    
    
    //MARK: viewdidload() method
override func viewDidLoad() {
        super.viewDidLoad()
        cview.register(UINib(nibName: "HotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hotcell")
    
}
    

    
}




//MARK: Extension :
extension HotScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
//MARK: CollectionView methods :
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parray.count
        
}

    
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cview.dequeueReusableCell(withReuseIdentifier: "hotcell", for: indexPath) as! HotCollectionViewCell
        
        cell.Label.text = darray[indexPath.row]
        cell.frontImage.image = parray[indexPath.row]
    
    DispatchQueue.global(qos: .userInteractive).async
      {
        let uiimage = self.parray[indexPath.row]
        let beginImage = CIImage(image: uiimage!)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(beginImage, forKey: "inputImage")
        filter?.setValue(5, forKey: "inputRadius")
        let outputImage = filter?.outputImage
        let cgimg = self.context.createCGImage(outputImage!,from: outputImage!.extent)
        let newImage = UIImage(cgImage: cgimg!)
        
        DispatchQueue.main.async {
            cell.backImage.image = newImage
        }
        
     }
    
        return cell
}
    
    
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4)
}
    
    
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyb = UIStoryboard(name: "ProductDetails", bundle: nil)
        let vc = storyb.instantiateViewController(withIdentifier: "pvc") as! ProductDetailsViewController
        vc.image = parray[indexPath.row]!
        vc.label = darray[indexPath.row]
        vc.price = price[indexPath.row]
        vc.colorA = UIColor(named: color[indexPath.row])!
        vc.colorName = color[indexPath.row]
        vc.popImage = parray[indexPath.row]!
        vc.popLabel = darray[indexPath.row]
        vc.popPrice = price[indexPath.row]
    
        self.navigationController?.pushViewController(vc, animated: true)
}
    
    
}
