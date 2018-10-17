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
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var viewBtnPropertyType: UIView!
    
    var propertyStatus: Int = 0
    var propertyType: Int = 0
    var propertyTypeString: String = ""
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
    
    var propertyTypeData = ["Apartemen", "Rumah", "Tanah", "Komersial", "Properti Baru"]
    var pickerPropertyType = UIPickerView()
    let alert = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewPropertySoldAction))
        propertyViewSold.addGestureRecognizer(gesture)
        
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(viewPropertyRentAction))
        propertyViewRent.addGestureRecognizer(gesture2)
        
        var pickerRect = pickerPropertyType.frame
        pickerRect.origin.x = -30
            pickerRect.origin.y = 0
            pickerPropertyType.frame = pickerRect
        pickerPropertyType.delegate = self
        pickerPropertyType.dataSource = self
        pickerPropertyType.isHidden = true
//        datePickerView.addTarget(self, action: #selector(PassengerAddController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        alert.isModalInPopover = true
        alert.view.addSubview(pickerPropertyType)
    }
    
    @objc func viewPropertySoldAction(){
        propertyStatus = 1
        radioPropertyStatusSold.image = UIImage(named:"radio-btn-checked.png")
        radioPropertyStatusRent.image = UIImage(named:"radio-btn-unchecked.png")
    }
    
    @objc func viewPropertyRentAction(){
        propertyStatus = 2
        radioPropertyStatusRent.image = UIImage(named:"radio-btn-checked.png")
        radioPropertyStatusSold.image = UIImage(named:"radio-btn-unchecked.png")
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
        pickerPropertyType.isHidden = false
        
        self.present(alert, animated: true, completion:{
            self.alert.view.superview?.isUserInteractionEnabled = true
            self.alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
        
        self.present(alert, animated: true)
    }
    
    @objc func alertControllerBackgroundTapped(){
        pickerPropertyType.isHidden = true
        self.dismiss(animated: true, completion: nil)
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return propertyTypeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return propertyTypeData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        propertyTypeString = propertyTypeData[row]
    }
}
