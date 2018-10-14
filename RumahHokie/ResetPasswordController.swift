//
//  ResetPasswordController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 12/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ResetPasswordController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPasswordConfirmation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func resetPasswordAction(_ sender: Any) {
        if self.oldPassword.text != "" && self.newPassword.text != "" && self.newPasswordConfirmation.text != ""{
            if(self.newPassword.text == self.newPasswordConfirmation.text){
                let group = DispatchGroup()
                group.enter()
                
                let decoded  = UserDefaults.standard.object(forKey: "UserToken") as! Data
                let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded)
                let bearerToken = decodedTeams!
                    as Any
                
                let data = [
                    "password" : self.newPassword.text!,
                    "old_password" : self.oldPassword.text!,
                ] as [String : Any]
                
                let header = [
                    "Authorization" : bearerToken
                ]
                
                DispatchQueue.main.async {
                    Alamofire.request("http://api.rumahhokie.com/agent/credential", method: .put, parameters: data as Parameters, encoding: URLEncoding.default, headers: header as? HTTPHeaders)
                        .responseJSON { response in
                            let resCode = response.response?.statusCode
                            
                            if(resCode == 200){
                                let vc = self.storyboard!.instantiateViewController(withIdentifier: "homeView") as? HomeController
                                self.navigationController!.pushViewController(vc!, animated: true)
                            } else{
                                let msgStatus: String = "Password Lama Tidak Cocok!"
                                let delay = DispatchTime.now() + 3
                                
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
            } else{
                let msgStatus: String = "Password dan Konfirmasi Password Harus Sama!"
                let delay = DispatchTime.now() + 3
                
                let alert = UIAlertController(title: msgStatus, message: "", preferredStyle: .alert)
                
                self.present(alert, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: delay){
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        } else{
            let msgStatus: String = "Harap isi semua field!"
            let delay = DispatchTime.now() + 3
            
            let alert = UIAlertController(title: msgStatus, message: "", preferredStyle: .alert)
            
            self.present(alert, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: delay){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
