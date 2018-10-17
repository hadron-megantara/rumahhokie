//
//  PropertyListController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 19/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PropertyListController: UIViewController {
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var whiteLineNew: UIView!
    @IBOutlet weak var whiteLinePopular: UIView!
    @IBOutlet weak var whiteLinePrice: UIView!
    @IBOutlet weak var whiteLineArea: UIView!
    
    var type: Int = 1
    var dataTotal: Int = 0
    var propertyListArray: Array = [Any]()
    var filterBy: String = "cnt_listing_publish_on"
    
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
    
    @IBAction func backToHome(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadList()
        
        whiteLineNew.backgroundColor = UIColor.white
        whiteLinePopular.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
        whiteLineArea.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
        whiteLinePrice.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
        
        if type == 1{
            navItem.title = "Rumah"
        } else if type == 2{
            navItem.title = "Apartemen"
        } else if type == 3{
            navItem.title = "Properti Baru"
        } else if type == 4{
            navItem.title = "Komersial"
        } else if type == 5{
            navItem.title = "Tanah"
        }
        
        let btnFilter = UIButton(type: .custom)
        btnFilter.setImage(UIImage(named: "filterIconWhite"), for: [])
        btnFilter.addTarget(self, action: #selector(openFilter), for: UIControlEvents.touchUpInside)
        navItem.rightBarButtonItem = UIBarButtonItem(customView: btnFilter)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 1000
        self.tableView.register(UINib(nibName: "EmptyListViewCell", bundle: nil), forCellReuseIdentifier: "EmptyListViewCell")
    }
    
    @objc func openFilter(){
        let vc = storyboard!.instantiateViewController(withIdentifier: "propertyFilterView") as? PropertyFilterController
        navigationController!.pushViewController(vc!, animated: true)
    }
    
    func loadList(){
        let group = DispatchGroup()
        group.enter()
        
        var typeId:Int = 1
        
        if(type == 1){
            typeId = 2
        } else if(type == 2){
            typeId = 1
        } else if(type == 3){
            typeId = 11
        } else if(type == 4){
            typeId = 10
        } else if(type == 5){
            typeId = 6
        }
        
        DispatchQueue.main.async {
            Alamofire.request("http://api.rumahhokie.com/cnt_listing?view=short&offset=0&limit=100&order_by="+self.filterBy+"&order_type=desc&mstr_status_id=1&mstr_tipe_id=\(typeId)", method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    if let res = (json as AnyObject).value(forKey: "cnt_listing"){
                        if let resArray = res as? Array<AnyObject>{
                            for r in resArray{
                                self.dataTotal = self.dataTotal + 1
                                
                                var dataId: Int = 0
                                var dataTitle: String = ""
                                var dataImage: String = ""
                                var dataProvince: String = ""
                                var dataCity: String = ""
                                var dataArea: String = ""
                                var dataPrice: Int = 0
                                var dataLb: Int = 0
                                var dataLt: Int = 0
                                var dataPublishOn: String = ""
                                var dataViewed: Int = 0
                                
                                if let objId = r["cnt_listing_id"] as? Int {
                                    dataId = objId
                                }
                                
                                if let objTitle = r["cnt_listing_name"] as? String {
                                    dataTitle = objTitle
                                }
                                
                                if let objPublishOn = r["cnt_listing_publish_on"] as? String {
                                    dataPublishOn = objPublishOn
                                }
                                
                                if let objViewed = r["view_count"] as? Int {
                                    dataViewed = objViewed
                                }
                                
                                if let objPrice = r["cnt_listing_harga"] as? Int {
                                    dataPrice = objPrice
                                }
                                
                                if let objLb = r["cnt_listing_lb"] as? Int {
                                    dataLb = objLb
                                }
                                
                                if let objLt = r["cnt_listing_lt"] as? Int {
                                    dataLt = objLt
                                }
                                
                                if let objProvince = r["mstr_provinsi"] as? [String:AnyObject] {
                                    dataProvince = objProvince["mstr_provinsi_desc"]! as! String
                                }
                                
                                if let objCity = r["mstr_kota"] as? [String:AnyObject] {
                                    dataCity = objCity["mstr_kota_desc"]! as! String
                                }
                                
                                if let objArea = r["mstr_wilayah"] as? [String:AnyObject] {
                                    dataArea = objArea["mstr_wilayah_desc"]! as! String
                                }
                                
                                if let objImg = r["cnt_foto"] as? Array<AnyObject> {
                                    if objImg.count > 0{
                                        for objImgLoop in objImg{
                                            dataImage = objImgLoop["nama_foto"] as! String
                                        }
                                    }
                                }
                                
                                let returnArray = [dataTitle, dataProvince, dataCity, dataArea, dataPrice, dataLb, dataLt, dataPublishOn, dataViewed, dataImage, dataId] as [Any]
                                self.propertyListArray.append(returnArray)
                            }
                        }
                    }
                }
                
                self.tableView.reloadData()
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
    }
    
    
    @IBAction func filterListing(_ sender: UIButton) {
        if(sender.tag == 10){
            self.filterBy = "cnt_listing_publish_on"
            
            whiteLineNew.backgroundColor = UIColor.white
            whiteLinePopular.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            whiteLineArea.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            whiteLinePrice.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
        } else if(sender.tag == 11){
            self.filterBy = "view_count"
            
            whiteLinePopular.backgroundColor = UIColor.white
            whiteLineNew.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            whiteLineArea.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            whiteLinePrice.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
        } else if(sender.tag == 12){
            self.filterBy = "cnt_listing_harga"
            
            whiteLinePrice.backgroundColor = UIColor.white
            whiteLineNew.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            whiteLineArea.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            whiteLinePopular.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
        } else if(sender.tag == 13){
            self.filterBy = "area"
            
            whiteLineArea.backgroundColor = UIColor.white
            whiteLineNew.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            whiteLinePrice.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            whiteLinePopular.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
        }
        
        self.propertyListArray.removeAll()
        loadList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PropertyListController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataTotal
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellListProperty", for: indexPath) as UITableViewCell
        
        
        if let objData = self.propertyListArray[indexPath.row] as? Array<AnyObject>{
            cell.tag = objData[10] as! Int
            
            if let label1 = cell.viewWithTag(1) as? UILabel{
                label1.text = objData[0] as? String
            }
            
            if let label2 = cell.viewWithTag(2) as? UILabel{
                label2.text = (objData[3] as? String)! + ", " + (objData[2] as? String)! + ", " + (objData[1] as? String)!
            }
            
            if let label3 = cell.viewWithTag(3) as? UILabel{
                var textPrice: String = ""
                var priceFinal: Float = 0
                
                if ((objData[4].floatValue) / 1000000000) >= 1{
                    textPrice = "M"
                    priceFinal = objData[4].floatValue / 1000000000
                } else{
                    textPrice = "juta"
                    priceFinal = objData[4].floatValue / 1000000
                }
                
                if let label10 = cell.viewWithTag(10) as? UILabel{
                    label10.text = textPrice
                }
                
                label3.text = String(format: "%.2f", priceFinal)
            }
            
            if let label4 = cell.viewWithTag(4) as? UILabel{
                label4.text = objData[5].stringValue
            }
            
            if let label5 = cell.viewWithTag(5) as? UILabel{
                label5.text = objData[6].stringValue
            }
            
            if let label6 = cell.viewWithTag(6) as? UILabel{
                label6.text = objData[7] as? String
            }
            
            if let label7 = cell.viewWithTag(7) as? UILabel{
                label7.text = objData[8].stringValue
            }
            
            if let label8 = cell.viewWithTag(8) as? UIImageView{
                if let objImg = objData[9] as? String {
                    let pictUrl = URL(string: "http://rumahhokie.com/upload-foto/"+objImg )!

                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: pictUrl){
                            if let dataImage = UIImage(data: data){
                                DispatchQueue.main.async {
                                    label8.image = dataImage
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return cell
    }
}

extension PropertyListController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "propertyDetailView") as? PropertyDetailController
        
        let currentCell = tableView.cellForRow(at: indexPath)
        
        vc?.idDetail = currentCell!.tag
        
        navigationController?.pushViewController(vc!, animated: true)
    }
}
