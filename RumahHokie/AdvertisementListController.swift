//
//  AdvertisementListController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 18/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AdvertisementListController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bottomMenu: BottomMenu!
    @IBOutlet weak var whiteLineNew: UIView!
    @IBOutlet weak var whiteLineMost: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var sideIsOpened: Bool = false
    var propertyListArray: Array = [Any]()
    var dataTotal: Int = 0
    var agentId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        whiteLineNew.backgroundColor = UIColor.white
        whiteLineMost.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        if UserDefaults.standard.object(forKey: "User") != nil{
            let decoded  = UserDefaults.standard.object(forKey: "User") as! Data
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded)
            
            agentId = ((decodedTeams as AnyObject).value(forKey: "agt_user_id") as? Int)!
            
            navigationController?.navigationBar.isHidden = false
            self.navigationItem.title = "Iklan Tayang"
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
            let btnFilter = UIButton(type: .custom)
            btnFilter.titleLabel?.font = UIFont(name: "FontAwesome", size: 20)
            btnFilter.setTitle("", for: .normal)
            
            btnFilter.addTarget(self, action: #selector(openFilter), for: UIControlEvents.touchUpInside)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnFilter)
            
            let bottomMenuView = Bundle.main.loadNibNamed("BottomMenuUser", owner: nil, options: nil)![0] as! UIView
            bottomMenuView.frame.size.width = bottomMenu.frame.width
            bottomMenu.addSubview(bottomMenuView)
        } else{
            navigationController?.navigationBar.isHidden = true
            
            let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
            bottomMenu.addSubview(bottomMenuView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.propertyListArray.removeAll()
        loadList()
    }
    
    func loadList(){
        let group = DispatchGroup()
        group.enter()
        
        let urlVar = "http://api.rumahhokie.com/agt_user/\(self.agentId)/cnt_listing?view=short&offset=0&limit=150&order_by=cnt_listing_publish_on&order_type=desc"
        
        DispatchQueue.main.async {
            Alamofire.request(urlVar, method: .get).responseJSON { response in
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
                                        dataImage = objImg[0]["nama_foto"] as! String
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
    
    @objc func openFilter(){
        //        let transition = CATransition()
        //        transition.duration = 0.5
        //        transition.type = kCATransitionPush
        //        transition.subtype = kCATransitionFromRight
        //        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        //
        
        if(!sideIsOpened){
            sideIsOpened = true
            let sideMenu = Bundle.main.loadNibNamed("SideBar", owner: nil, options: nil)![0] as! UIView
            sideMenu.frame.size.width = self.view.frame.width * 4/5
            sideMenu.frame.size.height = self.view.frame.height
            sideMenu.tag = 100
            
            self.view.superview?.isUserInteractionEnabled = true
            self.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
            
            UIView.transition(with: self.view, duration: 0.5, options:[],animations: {self.view.addSubview(sideMenu)}, completion: nil)
        } else{
            sideIsOpened = false
            let sideView = view.viewWithTag(100)
            sideView?.removeFromSuperview()
        }
    }
    
    @objc func alertControllerBackgroundTapped(){
        sideIsOpened = false
        let sideView = view.viewWithTag(100)
        sideView?.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension AdvertisementListController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataTotal
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellListPropertyAgentPublish", for: indexPath) as UITableViewCell
        
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

extension AdvertisementListController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "propertyDetailView") as? PropertyDetailController
        
        let currentCell = tableView.cellForRow(at: indexPath)
        
        vc?.idDetail = currentCell!.tag
        
        navigationController?.pushViewController(vc!, animated: true)
    }
}
