//
//  PropertyDetailController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 19/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import AACarousel
import Alamofire
import Kingfisher

class PropertyDetailController: UIViewController, AACarouselDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var carouselView: AACarousel!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblProductPlace: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblTimePost: UILabel!
    @IBOutlet weak var lblTotalSeen: UILabel!
    @IBOutlet weak var lblAreaBuilding: UILabel!
    @IBOutlet weak var lblAreaGround: UILabel!
    @IBOutlet weak var lblAreaBedRoom: UILabel!
    @IBOutlet weak var lblAreaBathRoom: UILabel!
    @IBOutlet weak var lblAreaGarage: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    @IBOutlet weak var lblAgentPropertyTotal: UILabel!
    @IBOutlet weak var lblAgentPropertySold: UILabel!
    @IBOutlet weak var lblAgentJoinedFrom: UILabel!
    @IBOutlet weak var imgAgentView: UIImageView!
    @IBOutlet weak var btnAgentMsg: UIButton!
    @IBOutlet weak var btnAgentCall: UIButton!
    
    var url = [String]()
    var titleArray = [String]()
    var idDetail: Int = 1
    
    @IBAction func backButtonAction(_ sender: Any) {
        let switchViewController = self.navigationController?.viewControllers[1] as! PropertyListController
        
        self.navigationController?.popToViewController(switchViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDetail()
        
        let btnShare = UIButton(type: .custom)
        btnShare.setImage(UIImage(named: "shareIconBlack"), for: [])
        //        btn_filter.addTarget(self, action: #selector(PPTrainSearchResultViewController.showFilter), for: UIControlEvents.touchUpInside)
        navItem.rightBarButtonItem = UIBarButtonItem(customView: btnShare)
    }
    
    func loadDetail(){
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Alamofire.request("http://api.rumahhokie.com/cnt_listing/\(self.idDetail)", method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    if let resImage = (json as AnyObject).value(forKey: "cnt_foto"){
                        if let resArray = resImage as? Array<AnyObject>{
                            for r in resArray{
                                let baseImgUrl = "http://rumahhokie.com/upload-foto/"
                                let resImage = r.value(forKey: "nama_foto") as! String
                                let resTitle = r.value(forKey: "nama_foto") as! String
                                
                                self.url.append(baseImgUrl+resImage)
                                self.titleArray.append(resTitle)
                            }
                        }

                        self.loadTopImage()
                    }
                    
                    if let resProductTitle = (json as AnyObject).value(forKey: "cnt_listing_name"){
                        self.lblProductTitle.text = resProductTitle as? String
                    }
                    
                    var resProductPlace: String = ""
                    if let resProductArea = (json as AnyObject).value(forKey: "mstr_wilayah"){
                        if let areaDetail = (resProductArea as AnyObject).value(forKey: "mstr_wilayah_desc"){
                            resProductPlace = areaDetail as! String
                        }
                    }
                    
                    if let resProductCity = (json as AnyObject).value(forKey: "mstr_kota"){
                        if let areaDetail: String = (resProductCity as AnyObject).value(forKey: "mstr_kota_desc") as? String{
                            resProductPlace = resProductPlace+", "+areaDetail
                        }
                    }
                    
                    if let resProductProvince = (json as AnyObject).value(forKey: "mstr_provinsi"){
                        if let areaDetail: String = (resProductProvince as AnyObject).value(forKey: "mstr_provinsi_desc") as? String{
                            resProductPlace = resProductPlace+", "+areaDetail
                        }
                    }
                    
                    if let resProductPrice = (json as AnyObject).value(forKey: "cnt_listing_harga"){
                        let numberFormatter = NumberFormatter()
                        numberFormatter.groupingSeparator = "."
                        numberFormatter.groupingSize = 3
                        numberFormatter.usesGroupingSeparator = true
                        
                        self.lblProductPrice.text = numberFormatter.string(from: resProductPrice as AnyObject as! NSNumber)!
                    }
                    
                    if let resProductPublishOn = (json as AnyObject).value(forKey: "cnt_listing_publish_on"){
                        self.lblTimePost.text = resProductPublishOn as? String
                    }
                    
                    if let resProductViewCount = (json as AnyObject).value(forKey: "view_count"){
                        self.lblTotalSeen.text = (resProductViewCount as AnyObject).stringValue
                    }
                    
                    if let resProductAreaBuilding = (json as AnyObject).value(forKey: "cnt_listing_lb"){
                        self.lblAreaBuilding.text = (resProductAreaBuilding as AnyObject).stringValue
                    }
                    
                    if let resProductAreaGround = (json as AnyObject).value(forKey: "cnt_listing_lt"){
                        self.lblAreaGround.text = (resProductAreaGround as AnyObject).stringValue
                    }
                    
                    if let resProductAreaBedRoom = (json as AnyObject).value(forKey: "cnt_listing_kmr_tdr"){
                        self.lblAreaBedRoom.text = (resProductAreaBedRoom as AnyObject).stringValue
                    }
                    
                    if let resProductAreaBathRoom = (json as AnyObject).value(forKey: "cnt_listing_kmr_mandi"){
                        self.lblAreaBathRoom.text = (resProductAreaBathRoom as AnyObject).stringValue
                    }
                    
                    if let resProductAgent = (json as AnyObject).value(forKey: "agt_user"){
                        if let resProductAgentName: String = (resProductAgent as AnyObject).value(forKey: "agt_name") as? String{
                            self.lblAgentName.text = resProductAgentName
                        }
                        
                        if let resProductAgentPropertyTotal: Int = (resProductAgent as AnyObject).value(forKey: "published_cnt_listing_count") as? Int{
                            self.lblAgentPropertyTotal.text = String(resProductAgentPropertyTotal)
                        }
                        
                        if let resProductAgentPropertySold: Int = (resProductAgent as AnyObject).value(forKey: "sold_cnt_listing_count") as? Int{
                            self.lblAgentPropertySold.text = String(resProductAgentPropertySold)
                        }
                        
                        if let resProductAgentJoinedFrom: String = (resProductAgent as AnyObject).value(forKey: "agt_created_on") as? String{
                            self.lblAgentJoinedFrom.text = resProductAgentJoinedFrom
                        }
                        
                        if let resProductAgentImg: String = (resProductAgent as AnyObject).value(forKey: "agt_image") as? String{
                            var pictUrlUnEncoded = "http://rumahhokie.com/"+resProductAgentImg
                            pictUrlUnEncoded = pictUrlUnEncoded.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                            let pictUrl = URL(string: pictUrlUnEncoded )!
                            
                            DispatchQueue.global().async {
                                if let data = try? Data(contentsOf: pictUrl){
                                    if let dataImage = UIImage(data: data){
                                        DispatchQueue.main.async {
                                            self.imgAgentView.image = dataImage
                                        }
                                    }
                                }
                            }
                        }
                        
                        if let resProductAgentPhone: String = (resProductAgent as AnyObject).value(forKey: "agt_telp") as? String{
                            self.btnAgentCall.accessibilityIdentifier = resProductAgentPhone
                            self.btnAgentMsg.accessibilityIdentifier = resProductAgentPhone
                        }
                        
                    }
                    
                    self.lblProductPlace.text = resProductPlace
                }
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
    }
    
    func loadTopImage(){
        let pathArray = self.url
        self.carouselView.delegate = self
        self.carouselView.setCarouselData(paths: pathArray,  describedTitle: self.titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "defaultImage")
        self.carouselView.setCarouselOpaque(layer: true, describedTitle: true, pageIndicator: false)
        self.carouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
    }
    
    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
        UIApplication.shared.open(URL(string: "http://rumahhokie.com")!, options: [:])
    }
    
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        imageView.kf.setImage(with: URL(string: url[index]), placeholder: UIImage.init(named: "defaultIcon"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
    }
    
    func downloadImages(_ url: String, _ index: Int) {
        let imageView = UIImageView()
        let urlAppended = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        imageView.kf.setImage(with: URL(string: urlAppended!)!, placeholder: UIImage.init(named: "defaultIcon"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            self.carouselView.images[index] = downloadImage!
        })
    }
    
    @IBAction func btnAgentMsgAction(_ sender: UIButton) {
        let sms: String = "sms:+"+String(self.btnAgentCall.accessibilityIdentifier!)
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
    
    @IBAction func btnAgentCallAction(_ sender: UIButton) {
        guard let url = URL(string: "tel://" + String(self.btnAgentCall.accessibilityIdentifier!)) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
