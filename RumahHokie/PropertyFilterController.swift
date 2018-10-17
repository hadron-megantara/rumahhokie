//
//  PropertyFilterController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 16/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class PropertyFilterController: UIViewController, UITextFieldDelegate {
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
    
    var propertyStatus: Int = 1
    var propertyType: Int = 1
    var propertyPrice: Int = 0
    var propertyProvince: Int = 1
    var propertyPriceMin: Int = 0
    var propertyPriceMax: Int = 0
    var propertyBuildingMin: Int = 0
    var propertyBuildingMax: Int = 0
    var propertyAreaMin: Int = 0
    var propertyAreaMax: Int = 0
    var propertyBedRoom: Int = 0
    var propertyBathroom: Int = 0
    var propertyGarage: Int = 0
    var propertyKeyword: String = ""
    @IBOutlet weak var propertyViewSold: UIView!
    @IBOutlet weak var propertyViewRent: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: "viewPropertySoldAction:")
        propertyViewSold.addGestureRecognizer(gesture)
    }
    
    func viewPropertySoldAction(sender:UITapGestureRecognizer){
        if let image = UIImage(named:"radio-btn-checked.png") {
            self.radioPropertyStatusSold.image( UIImage(named:"radio-btn-unchecked.png"), forControlState: .Normal)
        }
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
    
    @IBAction func btnSearchAction(_ sender: Any) {
        let switchViewController = self.navigationController?.viewControllers[1] as! PropertyListController
        switchViewController.propertyStatus = self.propertyStatus
        switchViewController.propertyType = self.propertyType
        switchViewController.propertyPrice = self.propertyPrice
        switchViewController.propertyProvince = self.propertyProvince
        switchViewController.propertyPriceMin = self.propertyPriceMin
        switchViewController.propertyPriceMax = self.propertyPriceMax
        switchViewController.propertyBuildingMin = self.propertyBuildingMin
        switchViewController.propertyBuildingMax = self.propertyBuildingMax
        switchViewController.propertyAreaMin = self.propertyAreaMin
        switchViewController.propertyAreaMax = self.propertyAreaMax
        switchViewController.propertyBedRoom = self.propertyBedRoom
        switchViewController.propertyBathroom = self.propertyBathroom
        switchViewController.propertyGarage = self.propertyGarage
        switchViewController.propertyKeyword = self.propertyKeyword
        
        self.navigationController?.popToViewController(switchViewController, animated: true)
    }
    
}
