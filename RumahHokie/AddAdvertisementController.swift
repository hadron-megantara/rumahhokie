//
//  AddAdvertisementController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 18/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AddAdvertisementController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var propertyViewSold: UIView!
    @IBOutlet weak var propertyViewRent: UIView!
    @IBOutlet weak var radioPropertyStatusSold: UIImageView!
    @IBOutlet weak var radioPropertyStatusRent: UIImageView!
    @IBOutlet weak var btnPropertyType: UIButton!
    @IBOutlet weak var btnPropertyProvince: UIButton!
    @IBOutlet weak var btnPropertyCity: UIButton!
    @IBOutlet weak var btnPropertyArea: UIButton!
    
    var propertyType: Int = 0
    var propertyTypeString: String = ""
    
    var propertyProvince: Int = 1
    var propertyProvinceString: String = ""
    
    var propertyCity: Int = 1
    var propertyCityString: String = ""
    
    var propertyArea: Int = 1
    var propertyAreaString: String = ""
    
    var propertyStatus: Int = 0
    var propertyTypeData = ["Apartemen", "Rumah", "Tanah", "Komersial", "Properti Baru"]
    var propertyProvinceData: Array = [Any]()
    var pickerPropertyProvince = UIPickerView()
    var propertyCityData: Array = [Any]()
    var pickerPropertyCity = UIPickerView()
    var propertyAreaData: Array = [Any]()
    var pickerPropertyArea = UIPickerView()
    var pickerPropertyType = UIPickerView()
    
    let alert = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    let alert2 = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    let alert3 = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    let alert4 = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProvince()
        
        navigationController?.navigationBar.isHidden = true
        
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
        
        var pickerRect3 = pickerPropertyCity.frame
        pickerRect3.origin.x = -30
        pickerRect3.origin.y = 0
        pickerPropertyCity.tag = 3
        pickerPropertyCity.frame = pickerRect3
        pickerPropertyCity.delegate = self
        pickerPropertyCity.dataSource = self
        pickerPropertyCity.isHidden = true
        
        var pickerRect4 = pickerPropertyArea.frame
        pickerRect4.origin.x = -30
        pickerRect4.origin.y = 0
        pickerPropertyArea.tag = 4
        pickerPropertyArea.frame = pickerRect4
        pickerPropertyArea.delegate = self
        pickerPropertyArea.dataSource = self
        pickerPropertyArea.isHidden = true
        
        alert2.isModalInPopover = true
        alert2.view.addSubview(pickerPropertyProvince)
        
        alert3.isModalInPopover = true
        alert3.view.addSubview(pickerPropertyCity)
        
        alert4.isModalInPopover = true
        alert4.view.addSubview(pickerPropertyArea)
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

    func loadCity(){
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Alamofire.request("http://api.rumahhokie.com/mstr_provinsi/\(self.propertyProvince)/mstr_kota?order_by=mstr_kota_desc&order_type=asc", method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    if let res = (json as AnyObject).value(forKey: "mstr_kota"){
                        if let resArray = res as? Array<AnyObject>{
                            for r in resArray{
                                self.propertyCityData.append(r)
                            }
                        }
                    }
                }
                
                self.pickerPropertyCity.delegate = self;
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
    }
    
    func loadArea(){
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Alamofire.request("http://api.rumahhokie.com/mstr_provinsi/\(self.propertyProvince)/mstr_kota/\(self.propertyCity)/mstr_wilayah?order_by=mstr_wilayah_desc&order_type=asc", method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    if let res = (json as AnyObject).value(forKey: "mstr_wilayah"){
                        if let resArray = res as? Array<AnyObject>{
                            for r in resArray{
                                self.propertyAreaData.append(r)
                            }
                        }
                    }
                }
                
                self.pickerPropertyArea.delegate = self;
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
        let vc = storyboard!.instantiateViewController(withIdentifier: "advertisementListView") as? AdvertisementListController
        navigationController!.pushViewController(vc!, animated: true)
    }
    
    @IBAction func propertyTypeAction(_ sender: Any) {
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
    
    @IBAction func propertyProvinceAction(_ sender: Any) {
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
    
    @IBAction func propertyCityAction(_ sender: Any) {
        pickerPropertyCity.isHidden = false
        
        self.present(alert3, animated: true, completion:{
            self.alert3.view.superview?.isUserInteractionEnabled = true
            self.alert3.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertController3BackgroundTapped)))
        })
    }
    
    @objc func alertController3BackgroundTapped(){
        pickerPropertyCity.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func propertyAreaAction(_ sender: Any) {
        pickerPropertyArea.isHidden = false
        
        self.present(alert4, animated: true, completion:{
            self.alert4.view.superview?.isUserInteractionEnabled = true
            self.alert4.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertController4BackgroundTapped)))
        })
    }
    
    @objc func alertController4BackgroundTapped(){
        pickerPropertyArea.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return propertyTypeData.count
        } else if pickerView.tag == 2{
            return propertyProvinceData.count
        } else if pickerView.tag == 3{
            return propertyCityData.count
        }
        
        return propertyAreaData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return propertyTypeData[row]
        } else if pickerView.tag == 2{
            let dataProvinceObj = propertyProvinceData[row] as AnyObject
            let dataProvince = dataProvinceObj.value(forKey: "mstr_provinsi_desc")
            
            return dataProvince as? String
        } else if pickerView.tag == 3{
            let dataCityObj = propertyCityData[row] as AnyObject
            let dataCity = dataCityObj.value(forKey: "mstr_kota_desc")
            
            return dataCity as? String
        }
        
        let dataAreaObj = propertyAreaData[row] as AnyObject
        let dataArea = dataAreaObj.value(forKey: "mstr_wilayah_desc")
        
        return dataArea as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            propertyTypeString = propertyTypeData[row]
            btnPropertyType.setTitle(propertyTypeString, for: UIControlState.normal)
            
            pickerPropertyType.isHidden = true
            alert.dismiss(animated: true, completion: nil)
            
            if propertyTypeString == "Apartemen"{
                propertyType = 1
            } else if propertyTypeString == "Rumah"{
                propertyType = 2
            } else if propertyTypeString == "Tanah"{
                propertyType = 6
            } else if propertyTypeString == "Komersial"{
                propertyType = 10
            } else if propertyTypeString == "Properti Baru"{
                propertyType = 11
            }
        } else if pickerView.tag == 2{
            let dataProvinceObj = propertyProvinceData[row] as AnyObject
            let dataProvinceString = dataProvinceObj.value(forKey: "mstr_provinsi_desc")
            let dataProvinceId = dataProvinceObj.value(forKey: "mstr_provinsi_id")
            
            loadCity()
            
            propertyProvinceString = dataProvinceString as! String
            propertyProvince = dataProvinceId as! Int
            btnPropertyProvince.setTitle(propertyProvinceString, for: UIControlState.normal)
            
            pickerPropertyProvince.isHidden = true
            alert2.dismiss(animated: true, completion: nil)
        } else if pickerView.tag == 3{
            let dataCityObj = propertyCityData[row] as AnyObject
            let dataCityString = dataCityObj.value(forKey: "mstr_kota_desc")
            let dataCityId = dataCityObj.value(forKey: "mstr_kota_id")
            
            loadArea()
            
            propertyCityString = dataCityString as! String
            propertyCity = dataCityId as! Int
            btnPropertyCity.setTitle(propertyCityString, for: UIControlState.normal)
            
            pickerPropertyCity.isHidden = true
            alert3.dismiss(animated: true, completion: nil)
        }  else if pickerView.tag == 4{
            let dataAreaObj = propertyAreaData[row] as AnyObject
            let dataAreaString = dataAreaObj.value(forKey: "mstr_wilayah_desc")
            let dataAreaId = dataAreaObj.value(forKey: "mstr_wilayah_id")
            
            propertyAreaString = dataAreaString as! String
            propertyArea = dataAreaId as! Int
            btnPropertyArea.setTitle(propertyAreaString, for: UIControlState.normal)
            
            pickerPropertyArea.isHidden = true
            alert4.dismiss(animated: true, completion: nil)
        }
    }
}
