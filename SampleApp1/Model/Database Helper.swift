//
//  Database Helper.swift
//  SampleApp1
//
//  Created by Anmol Kumar on 14/07/19.
//  Copyright © 2019 Anushka. All rights reserved.
//

import UIKit
import  Foundation
import CoreData

class DatabaseHelper{
    
    static var instance = DatabaseHelper()
//Context create
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

//Mark:- save in database
func save(object: [String:Any]){
    
        let cartItem = NSEntityDescription.insertNewObject(forEntityName:"CartItem", into: context!) as! CartItem
            cartItem.name = object["name"] as? String
            cartItem.image = object["image"] as? Data
            cartItem.price = object["price"] as! Double
            cartItem.colorName = object["colorname"] as? String
            cartItem.color = object["color"] as? String
            cartItem.number = object["number"] as! Double
     
            do{
                try context?.save()
            }catch{
                print("\ndata is not saved")
            }
    }

    
//Mark:- Change number of items in database
func changeValueForCartItem(newVal:Double,id:String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"CartItem")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "\(id)")
        print("updating data...")
        do
        {
            let fetchedResults =  try context!.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResults?.isEmpty == false{
                do
                {
                    fetchedResults![0].setValue(newVal, forKeyPath: "number")
                  try context!.save()
                 
                }
                catch let error as Error?
                {
                    print(error!.localizedDescription)
                }
            }else{return}
           
        }
        catch {
            print("Could not delete")
        }
    
}
   
    
        
        
        
//Mark:- get total price of items in cart
func getPrice()->Double{
        var cartItem = [CartItem]()
        var t = 0.0
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CartItem")
        do{
            cartItem = try context?.fetch(fetchRequest) as! [CartItem]
            if cartItem.isEmpty == false{
                for data in cartItem as [NSManagedObject] {
                    let n = data.value(forKey: "number") as! Double
                    let p = data.value(forKey: "price") as! Double
                    t=t+(n*p)
                }
            }
          
        }catch{
            print("\ncant get the data")
        }
        
        return t
    }
    
    

//Mark:- Get data from database
func getData()->[CartItem]{
        var cartItem = [CartItem]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CartItem")
        do{
            cartItem = try context?.fetch(fetchRequest) as! [CartItem]
        }catch{
            print("\ncant get the data")
        }
        
        return cartItem
    }
    
    
    
//Mark: Search if the item is present in Cart or not
func search(name: String)->Bool{
        var result: Bool = false
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"CartItem")
            fetchRequest.predicate = NSPredicate(format: "name = %@", "\(name)")
            print("searching...")
        do{
            let results = try context?.fetch(fetchRequest) as! [NSManagedObject]
            for entity in results{
                let v = entity.value(forKey: "name") as! String
                if  v.contains(name){
                    print("found")
                    result = true
                }else{
                    print("not found")
                    result = false
                }
            }
        }catch{
            print("return")
        }
    
      return result
    }
    
    
    
//Delete items from cart
func deleteData(Id:String)
    {
        if search(name: Id) == true{
            print("Deleting Data..")
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"CartItem")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "\(Id)")
                print("Deleting Data..")
                do
                {
                    let fetchedResults =  try context!.fetch(fetchRequest) as? [NSManagedObject]
                    for entity in fetchedResults! {
                       context!.delete(entity)
                        do
                        {
                            try context!.save()
                        }
                        catch let error as Error?
                        {
                            print(error!.localizedDescription)
                        }
                    }
                }
                catch _ {
                    print("Could not delete")
                }
    
        }
        else{
            print("could not found in cart")
        }
        
        
    }
    
  
    
    func retrieveNumberOfitems(id: String) -> Double {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItem")
        fetchRequest.predicate = NSPredicate(format: "name = %@", id)
        
        do {
            let results = try context!.fetch(fetchRequest) as? [NSManagedObject]
            let valueOfNo = results![0].value(forKey: "number")
            return valueOfNo as! Double
            
        }
        catch {
            print("Fetch Failed: \(error)")
            return 0
        }
        
    }
    
}
