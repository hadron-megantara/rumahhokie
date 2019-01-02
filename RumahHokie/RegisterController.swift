//
//  RegisterController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 19/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RegisterController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var whiteBar: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let agentType = ["Agen Independen","Agen Properti","Pemilik Properti"]
    var pickerViewVal: String = ""
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whiteBar.layer.borderWidth = 1
        whiteBar.layer.borderColor = UIColor.gray.cgColor
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        txtName.delegate = self
        txtPhone.delegate = self
        txtEmail.delegate = self
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
        pickerViewVal = agentType[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let group = DispatchGroup()
        group.enter()
        
        var agentStatus: Int = 0
        if pickerViewVal == "Agen Independen"{
            agentStatus = 2
        } else if pickerViewVal == "Agen Properti"{
            agentStatus = 8
        } else if pickerViewVal == "Pemilik Properti"{
            agentStatus = 9
        }
        
        let data = [
            "grant_type" : "password",
            "client_id" : "rumahhokie_private",
            "scope" : "agent",
            "username" : txtEmail.text!,
            "password" : "12345",
            "agt_email" : txtEmail.text!,
            "agt_name" : txtName.text!,
            "agt_telp" : txtPhone.text!,
            "agt_status_id" : agentStatus
            ] as [String : Any]
        
        DispatchQueue.main.async {
                
            Alamofire.request("http://api.rumahhokie.com/agent/account", method: .post, parameters: data as Parameters, encoding: URLEncoding.default, headers: nil)
                .responseData { response in
                    if let resCode = response.response?.statusCode{
                        var msgStatus: String = ""
                        var delay = DispatchTime.now()
                        
                        if resCode == 201{
                            msgStatus = "Register Berhasil, Silahkan Login dengan Password 12345"
                            delay = delay + 4
                        } else if resCode == 400{
                            msgStatus = "Akses Klien Tidak Valid!"
                            delay = delay + 3
                        } else if resCode == 409{
                            msgStatus = "Email telah dipakai!"
                            delay = delay + 3
                        }
                        
                        let alert = UIAlertController(title: msgStatus, message: "", preferredStyle: .alert)
                        
                        self.present(alert, animated: true)
                        
                        DispatchQueue.main.asyncAfter(deadline: delay){
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
            }

            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
    }
    
}
