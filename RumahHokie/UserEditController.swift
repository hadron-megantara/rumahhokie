//
//  UserEditController.swift
//  AACarousel
//
//  Created by Hadron Megantara on 15/10/18.
//

import Foundation
import UIKit

class UserEditController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var accountTypePicker: UIPickerView!
    @IBOutlet weak var constraintPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var btnChoosePhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
    }
}
