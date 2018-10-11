//
//  RegisterController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 19/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class RegisterController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var whiteBar: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let agentType = ["Agen Independen","Agen Properti","Pemilik Properti"]
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whiteBar.layer.borderWidth = 1
        whiteBar.layer.borderColor = UIColor.gray.cgColor
        
        pickerView.delegate = self
        pickerView.dataSource = self
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
    
    @IBAction func registerAction(_ sender: Any) {
        
    }
    
}
