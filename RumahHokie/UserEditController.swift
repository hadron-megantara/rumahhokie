//
//  UserEditController.swift
//  AACarousel
//
//  Created by Hadron Megantara on 15/10/18.
//

import Foundation
import UIKit

class UserEditController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UINavigationControllerDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var constraintPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var btnChoosePhoto: UIButton!
    @IBOutlet weak var btnAgentType: UIButton!
    
    var imagePicker = UIImagePickerController()
    var totalImage: Int = 0
    var userId: Int = 0
    var pickerAgentType = UIPickerView()
    let agentType = ["Agen Independen","Agen Properti","Pemilik Properti"]
    var agentTypeId: Int = 0
    var agentTypeString: String = ""
    let alert = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    var pickerViewVal: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let decoded  = UserDefaults.standard.object(forKey: "User") as! Data
        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded)
        
        userId = (decodedTeams as AnyObject).value(forKey: "agt_user_id") as! Int
        txtFullName.text = (decodedTeams as AnyObject).value(forKey: "agt_name") as? String
        txtPhone.text = (decodedTeams as AnyObject).value(forKey: "agt_telp") as? String
        txtEmail.text = (decodedTeams as AnyObject).value(forKey: "agt_email") as? String
        
        imagePicker.delegate = self
        
        var pickerRect = pickerAgentType.frame
        pickerRect.origin.x = -30
        pickerRect.origin.y = 0
        pickerAgentType.tag = 1
        pickerAgentType.frame = pickerRect
        pickerAgentType.delegate = self
        pickerAgentType.dataSource = self
        pickerAgentType.isHidden = true
        
        alert.isModalInPopover = true
        alert.view.addSubview(pickerAgentType)
        
        navigationController?.navigationBar.isHidden = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "userAccountView") as? UserAccountController
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        totalImage = 1
        imgPhoto.isHidden = false
        constraintPhotoHeight.constant = 100
        btnChoosePhoto.isHidden = true
        
        if let photo = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgPhoto.image = photo
            
            let gesturePhoto = UITapGestureRecognizer(target: self, action: #selector(imagePhotoRemove))
            imgPhoto.isUserInteractionEnabled = true
            imgPhoto.addGestureRecognizer(gesturePhoto)
        }
    }
    
    @objc func imagePhotoRemove(sender: UITapGestureRecognizer){
        if totalImage > 0 {
            totalImage = 0
            imgPhoto.isHidden = true
            constraintPhotoHeight.constant = 0
            btnChoosePhoto.isHidden = false
        }
    }
    
    @IBAction func chooseAgentType(_ sender: Any) {
        pickerAgentType.isHidden = false
        self.present(alert, animated: true, completion:{
            self.alert.view.superview?.isUserInteractionEnabled = true
            self.alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
    }
    
    @objc func alertControllerBackgroundTapped(){
        pickerAgentType.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return agentType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return agentType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        agentTypeString = agentType[row]
        btnAgentType.setTitle(agentTypeString, for: UIControlState.normal)
        
        pickerAgentType.isHidden = true
        alert.dismiss(animated: true, completion: nil)
        
        if agentTypeString == "Agen Independen"{
            agentTypeId = 2
        } else if agentTypeString == "Agen Properti"{
            agentTypeId = 8
        } else if agentTypeString == "Pemilik Properti"{
            agentTypeId = 9
        }
    }
}
