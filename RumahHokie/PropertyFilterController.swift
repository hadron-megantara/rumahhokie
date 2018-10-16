//
//  PropertyFilterController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 16/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class PropertyFilterController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var txtKeyWord: UITextField!
    @IBOutlet weak var radioPropertyStatusSold: UIImageView!
    @IBOutlet weak var radioPropertyStatusRent: UIImageView!
    @IBOutlet weak var btnPropertyType: UIButton!
    @IBOutlet weak var txtPriceMin: UITextField!
    @IBOutlet weak var txtPriceMax: UITextField!
    @IBOutlet weak var btnPropertyProvince: UIButton!
    @IBOutlet weak var txtPropertyBuildingMin: UITextField!
    @IBOutlet weak var txtPropertyBuildingMax: UITextField!
    @IBOutlet weak var txtPropertyAreaMin: UITextField!
    @IBOutlet weak var txtPropertyAreaMax: UITextField!
    @IBOutlet weak var txtPropertyBedRoom: UITextField!
    @IBOutlet weak var txtPropertyBathRoom: UITextField!
    @IBOutlet weak var txtPropertyGarage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: Any) {
        let switchViewController = self.navigationController?.viewControllers[1] as! PropertyListController
        
        self.navigationController?.popToViewController(switchViewController, animated: true)
    }
    
    @IBAction func btnPropertyTypeAction(_ sender: Any) {
        
    }
    
    @IBAction func btnPropertyProvinceAction(_ sender: Any) {
        
    }
    
}
