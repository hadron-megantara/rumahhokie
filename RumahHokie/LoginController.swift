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
                                        print(json2)
                                        let encodedData = NSKeyedArchiver.archivedData(withRootObject: json2)
                                        
                                        self.defaults.set(encodedData, forKey: "User")
                                    }
                                }
                                
                                group2.leave()
                            }
                            
                            group2.notify(queue: DispatchQueue.main) {
                                
                            }
                        }
                    }
            }
            
            if UserDefaults.standard.object(forKey: "User") != nil{
                let decoded  = UserDefaults.standard.object(forKey: "User") as! Data
                let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded)
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
