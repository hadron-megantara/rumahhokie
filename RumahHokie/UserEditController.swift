//
//  UserEditController.swift
//  AACarousel
//
//  Created by Hadron Megantara on 15/10/18.
//

import Foundation
import UIKit
import Alamofire

class UserEditController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UINavigationControllerDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var constraintPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var btnChoosePhoto: UIButton!
    @IBOutlet weak var btnAgentType: UIButton!
    
    let defaults = UserDefaults.standard
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
        
        if let agentStatusId = (decodedTeams as AnyObject).value(forKey: "agt_status_id") as? Int{
            agentTypeId = agentStatusId
            
            if agentStatusId == 2{
                btnAgentType.setTitle("Agen Independen", for: .normal)
            } else if agentStatusId == 8{
                btnAgentType.setTitle("Agen Properti", for: .normal)
            } else if agentStatusId == 9{
                btnAgentType.setTitle("Pemilik Properti", for: .normal)
            }
        }
        
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
        let group = DispatchGroup()
        group.enter()
        
        let data = [
            "agt_name" : txtFullName.text! as String,
            "agt_email" : txtEmail.text! as String,
            "agt_telp" : txtPhone.text! as String,
            "agt_status_id" : agentTypeId as Int
            ] as [String : Any]
        let url = "http://api.rumahhokie.com/agent/account"
        let decodedToken  = UserDefaults.standard.object(forKey: "UserToken") as! Data
        let bearerToken = NSKeyedUnarchiver.unarchiveObject(with: decodedToken)
        let header = [
            "Authorization" : bearerToken as! String
        ]
        
        DispatchQueue.main.async {
            Alamofire.request(url, method: .put, parameters: data, encoding: JSONEncoding.default, headers: header)
                .responseJSON { response in
                    let group2 = DispatchGroup()
                    group2.enter()
                    
                    DispatchQueue.main.async {
                        Alamofire.request("http://api.rumahhokie.com/agent/account", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
                            .responseJSON { response2 in
                                if let json2 = response2.result.value {
                                    let encodedData = NSKeyedArchiver.archivedData(withRootObject: json2)
                                    
                                    self.defaults.set(encodedData, forKey: "User")
                                }
                        }
                        
                        group2.leave()
                    }
                    
                    group2.notify(queue: DispatchQueue.main) {
                        
                    }
                    
                    if self.totalImage > 0{
                        let urlUpload = "http://api.rumahhokie.com/agent/account/profilepic"
                        
                        Alamofire.upload(multipartFormData: { multipartFormData in multipartFormData.append(UIImageJPEGRepresentation(self.imgPhoto.image!, 0.5)!, withName: "profilepic[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                        }, to: urlUpload,
                           headers: header,
                           encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    print(response)
                                    let vc = self.storyboard!.instantiateViewController(withIdentifier: "userAccountView") as? UserAccountController
                                    self.navigationController!.pushViewController(vc!, animated: true)
                                }
                            case .failure(let error):
                                print(error)
                            }
                            
                        })
                    } else{
                        let vc = self.storyboard!.instantiateViewController(withIdentifier: "userAccountView") as? UserAccountController
                        self.navigationController!.pushViewController(vc!, animated: true)
                    }
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
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
