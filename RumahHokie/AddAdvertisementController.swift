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
import OpalImagePicker

class AddAdvertisementController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, OpalImagePickerControllerDelegate {
    @IBOutlet weak var txtPropertyTitle: UITextField!
    @IBOutlet weak var txtPropertyAddress: UITextField!
    @IBOutlet weak var txtPropertyDesc: UITextField!
    @IBOutlet weak var txtPropertyBuilding: UITextField!
    @IBOutlet weak var txtPropertyArea: UITextField!
    @IBOutlet weak var txtPropertyBedRoom: UITextField!
    @IBOutlet weak var txtProperyBathRoom: UITextField!
    @IBOutlet weak var txtPropertyGarage: UITextField!
    @IBOutlet weak var txtPropertyPrice: UITextField!
    @IBOutlet weak var txtPropertyUrl: UITextField!
    @IBOutlet weak var txtPropertyTag: UITextField!
    @IBOutlet weak var propertyViewSold: UIView!
    @IBOutlet weak var propertyViewRent: UIView!
    @IBOutlet weak var radioPropertyStatusSold: UIImageView!
    @IBOutlet weak var radioPropertyStatusRent: UIImageView!
    @IBOutlet weak var btnPropertyType: UIButton!
    @IBOutlet weak var btnPropertyProvince: UIButton!
    @IBOutlet weak var btnPropertyCity: UIButton!
    @IBOutlet weak var btnPropertyArea: UIButton!
    @IBOutlet weak var btnUploadPhoto: UIButton!
    @IBOutlet weak var btnFacility: UIButton!
    @IBOutlet weak var btnFacilityArea: UIButton!
    @IBOutlet weak var viewUploadPhoto: UIView!
    @IBOutlet weak var constraintViewUploadPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintViewUploadPhotoWidth: NSLayoutConstraint!
    @IBOutlet weak var facilityText: UILabel!
    @IBOutlet weak var facilityText2: UILabel!
    @IBOutlet weak var constraintCoverHeight: NSLayoutConstraint!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var btnUploadCoverPhoto: UIButton!
    @IBOutlet weak var constraintBtnUploadCover: NSLayoutConstraint!
    
    var isSetCover: Bool = false
    
    var propertyType: Int = 0
    var propertyTypeString: String = ""
    
    var propertyProvince: Int = 0
    var propertyProvinceString: String = ""
    
    var propertyCity: Int = 0
    var propertyCityString: String = ""
    
    var propertyArea: Int = 0
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
    
    var propertyFeature: Array = [Any]()
    var propertyFeatureText: String = ""
    var propertyFeatureId: Array = [Any]()
    var propertyFeature2: Array = [Any]()
    var propertyFeatureText2: String = ""
    var propertyFeatureId2: Array = [Any]()
    
    let alert = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    let alert2 = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    let alert3 = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    let alert4 = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    
    let alert5 = UIAlertController(title: "Pilih Fasilitas", message: "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    let alert6 = UIAlertController(title: "Pilih Fasilitas Sekitar", message: "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
    
    private var featureTableView: UITableView!
    private var featureTableView2: UITableView!
    
    var imagePicker = OpalImagePickerController()
    var coverPicker = UIImagePickerController()
    var uploadImages: [UIImage] = []
    var totalImage: Int = 0
    let maxPhoto: Int = 15
    var tagVar: Int = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProvince()
        loadFeature()
        loadFeature2()
        
        coverPicker.delegate = self
        
        txtPropertyTitle.delegate = self
        txtPropertyAddress.delegate = self
        txtPropertyDesc.delegate = self
        txtPropertyBuilding.delegate = self
        txtPropertyArea.delegate = self
        txtPropertyBedRoom.delegate = self
        txtProperyBathRoom.delegate = self
        txtPropertyGarage.delegate = self
        txtPropertyPrice.delegate = self
        txtPropertyUrl.delegate = self
        txtPropertyTag.delegate = self
        
        constraintViewUploadPhotoHeight.constant = 0
        constraintCoverHeight.constant = 0
        
        let margin: CGFloat = 10.0
        
        btnUploadCoverPhoto.layer.borderWidth = 1
        btnUploadCoverPhoto.layer.borderColor = UIColor.gray.cgColor
        btnUploadCoverPhoto.widthAnchor.constraint(equalToConstant: btnUploadCoverPhoto.titleLabel!.intrinsicContentSize.width + margin * 2.0).isActive = true
        
        btnUploadPhoto.layer.borderWidth = 1
        btnUploadPhoto.layer.borderColor = UIColor.gray.cgColor
        btnUploadPhoto.widthAnchor.constraint(equalToConstant: btnUploadPhoto.titleLabel!.intrinsicContentSize.width + margin * 2.0).isActive = true
        
        btnFacility.layer.borderWidth = 1
        btnFacility.layer.borderColor = UIColor.gray.cgColor
        btnFacility.widthAnchor.constraint(equalToConstant: btnFacility.titleLabel!.intrinsicContentSize.width + margin * 2.0).isActive = true
        
        btnFacilityArea.layer.borderWidth = 1
        btnFacilityArea.layer.borderColor = UIColor.gray.cgColor
        btnFacilityArea.widthAnchor.constraint(equalToConstant: btnFacilityArea.titleLabel!.intrinsicContentSize.width + margin * 2.0).isActive = true
        
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
        
        alert5.isModalInPopover = true
        alert5.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        
        alert6.isModalInPopover = true
        alert6.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.featureTableView = UITableView(frame: CGRect(x: 24, y: 50, width: 220, height: 320))
        self.featureTableView.register(UITableViewCell.self, forCellReuseIdentifier: "featureCell")
        self.featureTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.featureTableView.isEditing = false
        self.featureTableView.allowsSelection = true
        self.featureTableView.tag = 1
        self.featureTableView.dataSource = self
        self.featureTableView.delegate = self
        self.alert5.view.addSubview(self.featureTableView)
        
        self.featureTableView2 = UITableView(frame: CGRect(x: 24, y: 50, width: 220, height: 320))
        self.featureTableView2.register(UITableViewCell.self, forCellReuseIdentifier: "featureCell2")
        self.featureTableView2.separatorStyle = UITableViewCellSeparatorStyle.none
        self.featureTableView2.isEditing = false
        self.featureTableView2.allowsSelection = true
        self.featureTableView2.tag = 2
        self.featureTableView2.dataSource = self
        self.featureTableView2.delegate = self
        self.alert6.view.addSubview(self.featureTableView2)
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
            
            self.propertyCityData.removeAll()
            loadCity()
            
            propertyProvinceString = dataProvinceString as! String
            propertyProvince = dataProvinceId as! Int
            
            propertyCity = 0
            propertyCityString = ""
            btnPropertyCity.setTitle("Pilih Kota ", for: .normal)
            
            propertyArea = 0
            propertyAreaString = ""
            btnPropertyArea.setTitle("Pilih Kota ", for: .normal)
            
            btnPropertyProvince.setTitle(propertyProvinceString, for: UIControlState.normal)
            
            pickerPropertyProvince.isHidden = true
            alert2.dismiss(animated: true, completion: nil)
        } else if pickerView.tag == 3{
            let dataCityObj = propertyCityData[row] as AnyObject
            let dataCityString = dataCityObj.value(forKey: "mstr_kota_desc")
            let dataCityId = dataCityObj.value(forKey: "mstr_kota_id")
            
            self.propertyAreaData.removeAll()
            loadArea()
            
            propertyCityString = dataCityString as! String
            propertyCity = dataCityId as! Int
            
            propertyArea = 0
            propertyAreaString = ""
            btnPropertyArea.setTitle("Pilih Kota ", for: .normal)
            
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func btnUploadCoverPhotoAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            coverPicker.sourceType = .savedPhotosAlbum;
            coverPicker.allowsEditing = false
            
            present(coverPicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnUploadPhotoAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker = OpalImagePickerController()
            imagePicker.imagePickerDelegate = self
            imagePicker.maximumSelectionsAllowed = 15
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            coverImage.image = image
            constraintCoverHeight.constant = 200
            constraintBtnUploadCover.constant = 0
            btnUploadCoverPhoto.isHidden = true
            isSetCover = true
            
            let gesturePhoto = UITapGestureRecognizer(target: self, action: #selector(imageCoverPhotoRemove))
            coverImage.isUserInteractionEnabled = true
            coverImage.addGestureRecognizer(gesturePhoto)
        }
    }
    
    @objc func imageCoverPhotoRemove(sender: UITapGestureRecognizer){
        constraintCoverHeight.constant = 0
        constraintBtnUploadCover.constant = 27
        btnUploadCoverPhoto.isHidden = false
        isSetCover = false
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        if totalImage <= maxPhoto - 1 {
            constraintViewUploadPhotoHeight.constant = 70
            
            for element in images {
                totalImage = totalImage + 1
                uploadImages.append(element)
                
                tagVar = tagVar + 1
                let xVar = (totalImage - 1) * 70 + (totalImage - 1) * 8
                let viewWidth = totalImage * 70 + totalImage * 8
                
                constraintViewUploadPhotoWidth.constant = CGFloat(viewWidth)
                
                let imageView = UIImageView(image: element)
                imageView.frame = CGRect(x: xVar, y: 0, width: 70, height: 70)
                
                let gesturePhoto = UITapGestureRecognizer(target: self, action: #selector(imagePhotoRemove))
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(gesturePhoto)
                imageView.tag = tagVar
                
                viewUploadPhoto.addSubview(imageView)
            }
            
        } else{
            let msgStatus: String = "Hanya diperbolehkan maksimum 15 foto!"
            let delay = DispatchTime.now() + 3
            
            let alert = UIAlertController(title: msgStatus, message: "", preferredStyle: .alert)
            
            self.present(alert, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: delay){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func imagePhotoRemove(sender: UITapGestureRecognizer){
        let tagSender = sender.view!.tag
        
        if self.view.viewWithTag(tagSender) != nil{
            self.view.viewWithTag(tagSender)!.removeFromSuperview()
            
            totalImage = totalImage - 1
            
            if totalImage == 0{
                constraintViewUploadPhotoHeight.constant = 0
            } else if tagSender < tagVar{
                for i in tagSender + 1 ..< tagVar + 1{
                    if self.view.viewWithTag(i) != nil{
                        var frm: CGRect = self.view.viewWithTag(i)!.frame
                        self.view.viewWithTag(i)!.frame = CGRect(x: frm.origin.x - 78, y: 0, width: 70, height: 70)
                        self.view.viewWithTag(i)?.tag = i - 1
                    }
                }
                
                tagVar = tagVar - 1
            }
        }
    }
    
    func loadFeature(){
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Alamofire.request("http://api.rumahhokie.com/mstr_fitur?order_by=mstr_fitur_desc&order_type=asc&mstr_fitur_kategori=1", method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    if let res = (json as AnyObject).value(forKey: "mstr_fitur"){
                        if let resArray = res as? Array<AnyObject>{
                            for r in resArray{
                                var dataId: Int = 0
                                var dataDesc: String = ""
                                
                                if let objId = r["mstr_fitur_id"] as? Int {
                                    dataId = objId
                                }
                                
                                if let objDesc = r["mstr_fitur_desc"] as? String {
                                    dataDesc = objDesc
                                }
                                
                                let status: Int = 0
                                
                                let returnArray = [dataId, dataDesc, status] as [Any]
                                
                                self.propertyFeature.append(returnArray)
                            }
                            
                            self.featureTableView.reloadData()
                        }
                    }
                }
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
    }
    
    @objc func checkBoxFeatureAction(sender: UIButton){
        if sender.isSelected
        {
            sender.isSelected = false
            let btnImage    = UIImage(named: "icon-checked")!
            sender.setBackgroundImage(btnImage, for: UIControlState())
        }else {
            sender.isSelected = true
            let btnImage    = UIImage(named: "icon-unchecked")!
            sender.setBackgroundImage(btnImage, for: UIControlState())
        }
    }
    
    @IBAction func btnFacilityAction(_ sender: Any) {
        self.present(alert5, animated: true, completion:{
            self.alert5.view.superview?.isUserInteractionEnabled = true
            self.alert5.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertController5BackgroundTapped)))
        })
    }
    
    @IBAction func btnFacility2Action(_ sender: Any) {
        self.present(alert6, animated: true, completion:{
            self.alert6.view.superview?.isUserInteractionEnabled = true
            self.alert6.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertController6BackgroundTapped)))
        })
    }
    
    @objc func alertController5BackgroundTapped(){
//        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func alertController6BackgroundTapped(){
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if totalImage > 0{
            if txtPropertyTitle.text != "" && self.propertyProvince > 0 && self.propertyCity > 0 && self.propertyArea > 0 && self.propertyType > 0 && txtPropertyBedRoom.text != "" && txtProperyBathRoom.text != "" && txtPropertyPrice.text != "" && txtPropertyBuilding.text != "" && txtPropertyArea.text != ""{
                let group = DispatchGroup()
                group.enter()
                
                let decoded  = UserDefaults.standard.object(forKey: "User") as! Data
                let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded)
                
                let userId = (decodedTeams as AnyObject).value(forKey: "agt_user_id") as? Int
                
                var paramPropertyFeature: Array = [Any]()
                
                for i in 0 ..< propertyFeatureId.count{
                    paramPropertyFeature.append(["mstr_fitur_id": propertyFeatureId[i]])
                }
                
                for i in 0 ..< propertyFeatureId2.count{
                    paramPropertyFeature.append(["mstr_fitur_id": propertyFeatureId2[i]])
                }
                
                let data = [
                    "stat" : 3,
                    "cnt_status_id" : 2,
                    "cnt_listing_name" : txtPropertyTitle.text!,
                    "cnt_listing_alamat" : txtPropertyAddress.text!,
                    "cnt_listing_desc" : txtPropertyDesc.text!,
                    "cnt_listing_url" : txtPropertyUrl.text!,
                    "mstr_status_id" : self.propertyStatus,
                    "mstr_provinsi_id" : self.propertyProvince,
                    "mstr_kota_id" : self.propertyCity,
                    "mstr_wilayah_id" : self.propertyArea,
                    "mstr_tipe_id" : self.propertyType,
                    "cnt_listing_kmr_tdr" : txtPropertyBedRoom.text!,
                    "cnt_listing_kmr_mandi" : txtProperyBathRoom.text!,
                    "cnt_listing_garasi" : txtPropertyGarage.text!,
                    "cnt_listing_harga" : txtPropertyPrice.text!,
                    "cnt_listing_lb" : txtPropertyBuilding.text!,
                    "cnt_listing_lt" : txtPropertyArea.text!,
                    "cnt_listing_tagging" : txtPropertyTag.text!,
                    "cnt_listing_created_on" : txtPropertyTitle.text!,
                    "cnt_fitur" : paramPropertyFeature,
                ] as [String : Any]
                let url = "http://api.rumahhokie.com/agt_user/\(userId ?? 0)/cnt_listing"
                
                let decodedToken  = UserDefaults.standard.object(forKey: "UserToken") as! Data
                let bearerToken = NSKeyedUnarchiver.unarchiveObject(with: decodedToken)
                let header = [
                    "Authorization" : bearerToken as! String
                ]
                
                DispatchQueue.main.async {
                    Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: header)
                        .responseJSON { response in
                            if let json = response.result.value {
                                if let listingId = (json as AnyObject).value(forKey: "cnt_listing_id"){
                                    let urlUploadCover = "http://api.rumahhokie.com/agt_user/\(userId ?? 0)/cnt_listing/\(listingId)/cnt_foto/cover"
                                    
                                    Alamofire.upload(multipartFormData: { multipartFormData in multipartFormData.append(UIImageJPEGRepresentation(self.coverImage.image!, 0.5)!, withName: "cnt_foto[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                                    }, to: urlUploadCover,
                                       encodingCompletion: { encodingResult in
                                        switch encodingResult {
                                        case .success(let upload, _, _):
                                            upload.responseJSON { response in
                                                let urlUpload = "http://api.rumahhokie.com/agt_user/\(userId ?? 0)/cnt_listing/\(listingId)/cnt_foto"
                                                
                                                Alamofire.upload(multipartFormData: { multipartFormData in
                                                    for imageData in self.uploadImages { multipartFormData.append(UIImageJPEGRepresentation(imageData, 0.5)!, withName: "cnt_foto[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                                                    }
                                                }, to: urlUpload,
                                                   encodingCompletion: { encodingResult in
                                                    switch encodingResult {
                                                    case .success(let upload, _, _):
                                                        upload.responseJSON { response in
                                                            let vc = self.storyboard!.instantiateViewController(withIdentifier: "advertisementListView") as? AdvertisementListController
                                                            self.navigationController!.pushViewController(vc!, animated: true)
                                                        }
                                                    case .failure(let error):
                                                        print(error)
                                                    }
                                                    
                                                })
                                            }
                                        case .failure(let error):
                                            print(error)
                                        }
                                        
                                    })
                                }
                            }
                    }
                    
                    group.leave()
                }
                
                group.notify(queue: DispatchQueue.main) {
                    
                }
            } else{
                let msgStatus: String = "Posting tidak bisa dilanjutkan, silahkan melengkapi data yang diperlukan"
                let delay = DispatchTime.now() + 3
                
                let alert = UIAlertController(title: msgStatus, message: "", preferredStyle: .alert)
                
                self.present(alert, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: delay){
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        } else{
            let msgStatus: String = "Posting tidak bisa dilanjutkan karena belum ada gambar yang diupload!"
            let delay = DispatchTime.now() + 3
            
            let alert = UIAlertController(title: msgStatus, message: "", preferredStyle: .alert)
            
            self.present(alert, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: delay){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1{
            return self.propertyFeature.count
        }
        
        return self.propertyFeature2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "featureCell", for: indexPath as IndexPath)
            
            if let objData = self.propertyFeature[indexPath.row] as? Array<AnyObject>{
                cell.textLabel?.font = UIFont(name: "FontAwesome", size: 14)
                cell.backgroundColor = UIColor.white
                
                if objData[2] as! Int == 0{
                    cell.textLabel!.text = "     " + (objData[1] as! String)
                } else{
                    cell.textLabel!.text = "     " + (objData[1] as! String)
                }
                
                cell.tag = indexPath.row
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(featureTableTap))
                cell.addGestureRecognizer(gesture)
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "featureCell2", for: indexPath as IndexPath)
        
        if let objData = self.propertyFeature2[indexPath.row] as? Array<AnyObject>{
            cell.textLabel?.font = UIFont(name: "FontAwesome", size: 14)
            cell.backgroundColor = UIColor.white
            
            if objData[2] as! Int == 0{
                cell.textLabel!.text = "     " + (objData[1] as! String)
            } else{
                cell.textLabel!.text = "     " + (objData[1] as! String)
            }
            
            cell.tag = indexPath.row
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(featureTableTap2))
            cell.addGestureRecognizer(gesture)
        }
        
        return cell
    }
    
    @objc func featureTableTap(sender: UITapGestureRecognizer){
        if let propertyData = self.propertyFeature as? Array<AnyObject>{
            var objIndexId: Int = 0
            if let objIndex = self.propertyFeature[(sender.view?.tag)!] as? Array<AnyObject>{
                objIndexId = objIndex[0] as! Int
            }
            
            self.propertyFeature.removeAll()
            self.propertyFeatureId.removeAll()
            
            self.propertyFeatureText = ""
            
            for r in propertyData{
                if var respond = r as? Array<AnyObject>{
                    var dataId: Int = 0
                    var dataDesc: String = ""
                    var dataStatus: Int = 0

                    if let objId = respond[0] as? Int {
                        dataId = objId
                    }

                    if let objDesc = respond[1] as? String {
                        dataDesc = objDesc
                    }
                    
                    if let objStatus = respond[2] as? Int {
                        if dataId == objIndexId{
                            if objStatus == 0{
                                dataStatus = 1
                            } else{
                                dataStatus = 0
                            }
                        } else{
                            dataStatus = objStatus
                        }
                        
                        if dataStatus == 1{
                            if self.propertyFeatureText == ""{
                                self.propertyFeatureText = dataDesc
                            } else{
                                self.propertyFeatureText = self.propertyFeatureText + ", " + dataDesc
                            }
                            
                            self.propertyFeatureId.append(dataId)
                        }
                    }

                    let returnArray = [dataId, dataDesc, dataStatus] as [Any]

                    self.propertyFeature.append(returnArray)
                }
            }
            
            facilityText.text = self.propertyFeatureText
        }
        
        self.featureTableView.reloadData()
    }
    
    func loadFeature2(){
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Alamofire.request("http://api.rumahhokie.com/mstr_fitur?order_by=mstr_fitur_desc&order_type=asc&mstr_fitur_kategori=2", method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    if let res = (json as AnyObject).value(forKey: "mstr_fitur"){
                        if let resArray = res as? Array<AnyObject>{
                            for r in resArray{
                                var dataId: Int = 0
                                var dataDesc: String = ""
                                
                                if let objId = r["mstr_fitur_id"] as? Int {
                                    dataId = objId
                                }
                                
                                if let objDesc = r["mstr_fitur_desc"] as? String {
                                    dataDesc = objDesc
                                }
                                
                                let status: Int = 0
                                
                                let returnArray = [dataId, dataDesc, status] as [Any]
                                
                                self.propertyFeature2.append(returnArray)
                            }
                            
                            self.featureTableView2.reloadData()
                        }
                    }
                }
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
    }
    
    @objc func featureTableTap2(sender: UITapGestureRecognizer){
        if let propertyData = self.propertyFeature2 as? Array<AnyObject>{
            var objIndexId: Int = 0
            if let objIndex = self.propertyFeature2[(sender.view?.tag)!] as? Array<AnyObject>{
                objIndexId = objIndex[0] as! Int
            }
            
            self.propertyFeature2.removeAll()
            self.propertyFeatureId2.removeAll()
            
            self.propertyFeatureText2 = ""
            
            for r in propertyData{
                if var respond = r as? Array<AnyObject>{
                    var dataId: Int = 0
                    var dataDesc: String = ""
                    var dataStatus: Int = 0
                    
                    if let objId = respond[0] as? Int {
                        dataId = objId
                    }
                    
                    if let objDesc = respond[1] as? String {
                        dataDesc = objDesc
                    }
                    
                    if let objStatus = respond[2] as? Int {
                        if dataId == objIndexId{
                            if objStatus == 0{
                                dataStatus = 1
                            } else{
                                dataStatus = 0
                            }
                        } else{
                            dataStatus = objStatus
                        }
                        
                        if dataStatus == 1{
                            if self.propertyFeatureText2 == ""{
                                self.propertyFeatureText2 = dataDesc
                            } else{
                                self.propertyFeatureText2 = self.propertyFeatureText2 + ", " + dataDesc
                            }
                            
                            self.propertyFeatureId2.append(dataId)
                        }
                    }
                    
                    let returnArray = [dataId, dataDesc, dataStatus] as [Any]
                    
                    self.propertyFeature2.append(returnArray)
                }
            }
            
            facilityText2.text = self.propertyFeatureText2
        }
        
        self.featureTableView2.reloadData()
    }
}
