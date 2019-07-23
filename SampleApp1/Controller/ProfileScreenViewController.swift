//
//  ProfileScreenViewController.swift
//  SampleApp1
//
//  Created by Anmol Kumar on 09/07/19.
//  Copyright © 2019 Anushka. All rights reserved.
//

import UIKit

class ProfileScreenViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    //MARK: Outlets
    @IBOutlet var imageview: DesignableView!
    @IBOutlet var photo: DesignableImage!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var editName: UITextField!
    @IBOutlet var editDescription: UITextView!
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var editButton: UIBarButtonItem!
    
    //MARK: variables declared
    var name = "Tim Cook"
    var des = "I love to buy tech gadgets."
    let imagePicker = UIImagePickerController()
    var isPickedBefore = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        nameLabel.text = name
        descriptionLabel.text = des
        imageview.layer.cornerRadius = imageview.frame.width/2
        photo.layer.cornerRadius = photo.frame.width/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if isPickedBefore == true{
            editState()
        }
        else{
            nameLabel.text = name
            descriptionLabel.text = des
            editDescription.isHidden = true
            editName.isHidden = true
            editButton.isEnabled = true
            doneButton.isEnabled = false
            doneButton.tintColor = .clear
            editButton.tintColor = .white
            
        }
       
    }
    
    //MARK: Logout button
    @IBAction func logOutButton(_ sender: UIButton) {
        
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
        UserDefaults.standard.setValue(nil, forKey: "email")
        UserDefaults.standard.synchronize()
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "lvc")
        let navVC = UINavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: true)
        let share = UIApplication.shared.delegate as? AppDelegate
        share?.window?.rootViewController = navVC
        share?.window?.makeKeyAndVisible()
        
       
        
    }
   
    //Edit button pressed
    @IBAction func editButtonPressed(_ sender: Any) {
        editState()
    }
    
    //Done button pressed
    @IBAction func doneButton(_ sender: Any) {
        doneState()
    }
    
    
    //MARK: didfinishPickingMedia method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            photo.image =  image
        }
        dismiss(animated: true, completion: nil)
        isPickedBefore = true
        
        
    }
    
    @objc func pickPhoto(){
           self.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: Edit state
    func editState(){
        editName.isHidden = false
        editDescription.isHidden = false
        doneButton.isEnabled = true
        editButton.isEnabled = false
        doneButton.tintColor = .white
        editButton.tintColor = .clear
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickPhoto))
        photo.addGestureRecognizer(tap)
        photo.isUserInteractionEnabled = true
    }
   
    //MARK: Done state
    func doneState(){
        name = editName.text!
        des = editDescription.text!
        nameLabel.text = name
        descriptionLabel.text = des
        editDescription.isHidden = true
        editName.isHidden = true
        editButton.isEnabled = true
        doneButton.isEnabled = false
        doneButton.tintColor = .clear
        editButton.tintColor = .white
        
        
        isPickedBefore = false
    }
    
}
