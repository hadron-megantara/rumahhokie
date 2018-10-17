//
//  PropertyFilterController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 16/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PropertyFilterController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var txtKeyWord: UITextField!
    @IBOutlet weak var radioPropertyStatusSold: UIImageView!
    @IBOutlet weak var radioPropertyStatusRent: UIImageView!
    @IBOutlet weak var btnPropertyType: UIButton!
    @IBOutlet weak var txtPriceMin: UITextField!{
        didSet {
            txtPriceMin?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
    }
    
    @IBOutlet weak var txtPriceMax: UITextField!{
        didSet {
            txtPriceMax?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
    }
    
    @IBOutlet weak var btnPropertyProvince: UIButton!
    @IBOutlet weak var txtPropertyBuildingMin: UITextField!{
        didSet {
            txtPropertyBuildingMin?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
    }
    
    @IBOutlet weak var txtPropertyBuildingMax: UITextField!{
        didSet {
            txtPropertyBuildingMax?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
    }
    
    @IBOutlet weak var txtPropertyAreaMin: UITextField!{
        didSet {
            txtPropertyAreaMin?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
    }
    
    @IBOutlet weak var txtPropertyAreaMax: UITextField!{
        didSet {
            txtPropertyAreaMax?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
    }
    
    @IBOutlet weak var txtPropertyBedRoom: UITextField!{
        didSet {
            txtPropertyBedRoom?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
    }
    
    @IBOutlet weak var txtPropertyBathRoom: UITextField!{
        didSet {
            txtPropertyBathRoom?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
    }
    
    @IBOutlet weak var txtPropertyGarage: UITextField!{
        didSet {
            txtPropertyGarage?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
    }
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var viewBtnPropertyType: UIView!
    
    let defaults = UserDefaults.standard
    var propertyStatus: Int = 0
    var propertyType: Int = 0
    var propertyTypeString: String = ""
    var propertyPrice: Int = 0
    var propertyProvince: Int = 1
    var propertyProvinceString: String = ""
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
    var propertyProvinceData: Array = [Any]()
    var pickerPropertyType = UIPickerView()
    var pickerPropertyProvince = UIPickerView()
    let alert = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    let alert2 = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        propertyProvinceData.append(["mstr_provinsi_id": 0, "mstr_provinsi_desc": "Semua"])
        
        loadProvince()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewPropertySoldAction))
        propertyViewSold.addGestureRecognizer(gesture)
        
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(viewPropertyRentAction))
        propertyViewRent.addGestureRecognizer(gesture2)
        
        var pickerRect = pickerPropertyType.frame
        pickerRect.origin.x = -30
        pickerRect.origin.y = 0
        pickerPropertyType.tag = 1
        pickerPropertyType.frame = pickerRect
        pickerPropertyType.delegate = self
        pickerPropertyType.dataSource = self
        pickerPropertyType.isHidden = true
        
        alert.isModalInPopover = true
        alert.view.addSubview(pickerPropertyType)
        
        var pickerRect2 = pickerPropertyProvince.frame
        pickerRect2.origin.x = -30
        pickerRect.origin.y = 0
        pickerPropertyProvince.tag = 2
        pickerPropertyProvince.frame = pickerRect2
        pickerPropertyProvince.delegate = self
        pickerPropertyProvince.dataSource = self
        pickerPropertyProvince.isHidden = true
        
        alert2.isModalInPopover = true
        alert2.view.addSubview(pickerPropertyProvince)
        
        txtPriceMin.delegate = self
        txtPriceMin.keyboardType = .decimalPad
        
        txtPriceMax.delegate = self
        txtPriceMax.keyboardType = .decimalPad
        
        txtPropertyBuildingMin.delegate = self
        txtPropertyBuildingMin.keyboardType = .decimalPad
        
        txtPropertyBuildingMax.delegate = self
        txtPropertyBuildingMax.keyboardType = .decimalPad
        
        txtPropertyAreaMin.delegate = self
        txtPropertyAreaMin.keyboardType = .decimalPad
        
        txtPropertyAreaMax.delegate = self
        txtPropertyAreaMax.keyboardType = .decimalPad
        
        txtPropertyBedRoom.delegate = self
        txtPropertyBedRoom.keyboardType = .decimalPad
        
        txtPropertyBathRoom.delegate = self
        txtPropertyBathRoom.keyboardType = .decimalPad
        
        txtPropertyGarage.delegate = self
        txtPropertyGarage.keyboardType = .decimalPad
        
    }
    
    func loadProvince(){
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Alamofire.request("http://api.rumahhokie.com/mstr_provinsi?order_by=mstr_provinsi_desc&order_type=asc", method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    if let res = (json as AnyObject).value(forKey: "mstr_provinsi"){
                        if let resArray = res as? Array<AnyObject>{
                            for r in resArray{
                                self.propertyProvinceData.append(r)
                            }
                        }
                    }
                }
                
                self.pickerPropertyProvince.delegate = self;
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
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
        
    }
    
    @objc func alertControllerBackgroundTapped(){
        pickerPropertyType.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPropertyProvinceAction(_ sender: Any) {
        pickerPropertyProvince.isHidden = false
        
        self.present(alert2, animated: true, completion:{
            self.alert2.view.superview?.isUserInteractionEnabled = true
            self.alert2.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertController2BackgroundTapped)))
        })
    }
    
    @objc func alertController2BackgroundTapped(){
        pickerPropertyProvince.isHidden = true
        self.dismiss(animated: true, completion: nil)
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
        if pickerView.tag == 1{
            return propertyTypeData.count
        } else{
            return propertyProvinceData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return propertyTypeData[row]
        } else{
            let dataProvinceObj = propertyProvinceData[row] as AnyObject
            let dataProvince = dataProvinceObj.value(forKey: "mstr_provinsi_desc")
            
            return dataProvince as? String
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            propertyTypeString = propertyTypeData[row]
            btnPropertyType.setTitle(propertyTypeString, for: UIControlState.normal)
            
            pickerPropertyType.isHidden = true
            alert.dismiss(animated: true, completion: nil)
        } else{
            let dataProvinceObj = propertyProvinceData[row] as AnyObject
            let dataProvinceString = dataProvinceObj.value(forKey: "mstr_provinsi_desc")
            let dataProvinceId = dataProvinceObj.value(forKey: "mstr_provinsi_id")
            
            propertyProvinceString = dataProvinceString as! String
            propertyProvince = dataProvinceId as! Int
            btnPropertyProvince.setTitle(propertyProvinceString, for: UIControlState.normal)
            
            pickerPropertyProvince.isHidden = true
            alert2.dismiss(animated: true, completion: nil)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    @objc func doneButtonTappedForMyNumericTextField() {
        txtPriceMin.resignFirstResponder()
        txtPriceMax.resignFirstResponder()
        txtPropertyBuildingMin.resignFirstResponder()
        txtPropertyBuildingMax.resignFirstResponder()
        txtPropertyAreaMin.resignFirstResponder()
        txtPropertyAreaMax.resignFirstResponder()
        txtPropertyBedRoom.resignFirstResponder()
        txtPropertyBathRoom.resignFirstResponder()
        txtPropertyGarage.resignFirstResponder()
    }
}

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}

