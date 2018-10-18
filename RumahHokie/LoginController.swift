//
//  LoginController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 19/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class LoginController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var whiteBar: UIView!
    
    let defaults = UserDefaults.standard
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let group = DispatchGroup()
        group.enter()
        
        let data = [
            "username" : txtEmail.text!,
            "password" : txtPassword.text!,
            "grant_type" : "password",
            "client_id" : "rumahhokie_private",
            "scope" : "agent"
        ] as [String : Any]
        
        DispatchQueue.main.async {
            
            Alamofire.request("http://api.rumahhokie.com/token", method: .post, parameters: data as Parameters, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    if let json = response.result.value {
                        
                        let resCode = response.response?.statusCode
                        
                        if(resCode == 200){
                            if let accessToken = (json as AnyObject).value(forKey: "access_token"){
                                let bearerToken: String = "Bearer " + String(describing: accessToken)
                                let group2 = DispatchGroup()
                                group2.enter()
                                
                                let header = [
                                    "Authorization" : bearerToken
                                ]
                                
                                DispatchQueue.main.async {
                                    Alamofire.request("http://api.rumahhokie.com/agent/account", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
                                        .responseJSON { response2 in
                                        if let json2 = response2.result.value {
                                            let encodedData = NSKeyedArchiver.archivedData(withRootObject: json2)
                                            
                                            self.defaults.set(encodedData, forKey: "User")
                                            
                                            let encodedData2 = NSKeyedArchiver.archivedData(withRootObject: bearerToken)
                                            
                                            self.defaults.set(encodedData2, forKey: "UserToken")
                                            
                                            if self.txtPassword.text != "12345"{
                                                let vc = self.storyboard!.instantiateViewController(withIdentifier: "advertisementListView") as? AdvertisementListController
                                                self.navigationController!.pushViewController(vc!, animated: true)
                                            } else{
                                                let vc = self.storyboard!.instantiateViewController(withIdentifier: "resetPasswordView") as? ResetPasswordController
                                                self.navigationController!.pushViewController(vc!, animated: true)
                                            }
                                        }
                                    }
                                    
                                    group2.leave()
                                }
                                
                                group2.notify(queue: DispatchQueue.main) {
                                    
                                }
                            }
                        } else{
                            let msgStatus: String = "Email atau Password salah. Silahkan Masukkan Data yang Valid"
                            let delay = DispatchTime.now() + 3
                            
                            let alert = UIAlertController(title: msgStatus, message: "", preferredStyle: .alert)
                            
                            self.present(alert, animated: true)
                            
                            DispatchQueue.main.asyncAfter(deadline: delay){
                                alert.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPassword.isSecureTextEntry = true
        
        whiteBar.layer.borderWidth = 1
        whiteBar.layer.borderColor = UIColor.gray.cgColor
    }
}
