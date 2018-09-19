//
//  LoginController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 19/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var whiteBar: UIView!
    
    
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whiteBar.layer.borderWidth = 1
        whiteBar.layer.borderColor = UIColor.gray.cgColor
    }
}
