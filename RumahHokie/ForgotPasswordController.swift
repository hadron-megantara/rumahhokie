//
//  ForgotPasswordController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 22/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ForgotPasswordController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtMail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: Any) {
        let switchViewController = self.navigationController?.viewControllers[1] as! LoginController
        
        self.navigationController?.popToViewController(switchViewController, animated: true)
    }
    
    @IBAction func resetPasswordAction(_ sender: Any) {
        let group = DispatchGroup()
        group.enter()
        
        let data = [
            "agt_email" : txtMail.text!
            ]
        
        DispatchQueue.main.async {
            
            Alamofire.request("http://api.rumahhokie.com/reset_password", method: .post, parameters: data as Parameters, encoding: URLEncoding.default, headers: nil)
                .responseData { response in
                    if let resCode = response.response?.statusCode{
                        var msgStatus: String = ""
                        let delay = DispatchTime.now() + 3
                        
                        if resCode == 201{
                            msgStatus = "Email untuk reset password telah dikirimkan ke email: \(self.txtMail.text!)"
                        } else if resCode == 404{
                            msgStatus = "Reset password gagal, email tidak ditemukan!"
                        } else if resCode == 505{
                            msgStatus = "Reset password gagal, gagal mengirim email!"
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
