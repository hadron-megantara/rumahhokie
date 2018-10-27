//
//  HomeController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 13/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import UIKit
import AACarousel
import Alamofire
import Kingfisher

class HomeController: UIViewController, AACarouselDelegate {
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var carouselView: AACarousel!
    @IBOutlet var TopMenuButton: [UIButton]!
    @IBOutlet var bannerMidRectangle: [UIImageView]!
    @IBOutlet var bannerMidSquare: [UIImageView]!
    @IBOutlet weak var scrollViewTopListing: UIScrollView!
    @IBOutlet weak var topListingView: UIView!
    @IBOutlet weak var constraintTopListingViewWidth: NSLayoutConstraint!
    
    var sideIsOpened: Bool = false
    var topListingArray: Array = [Any]()
    
    @IBAction func openPropertyList(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "propertyListView") as? PropertyListController
        
        if sender.tag == 1{
            vc?.type = 1
        } else if sender.tag == 2 {
            vc?.type = 2
        } else if sender.tag == 3 {
            vc?.type = 3
        } else if sender.tag == 4 {
            vc?.type = 4
        } else if sender.tag == 5 {
            vc?.type = 5
        }
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    var url = [String]()
    var titleArray = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        loadTopListing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        loadTopBanner()
        
        if UserDefaults.standard.object(forKey: "User") != nil{
            navigationController?.navigationBar.isHidden = false
            self.navigationItem.title = "Filter"
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
            let btnFilter = UIButton(type: .custom)
            btnFilter.titleLabel?.font = UIFont(name: "FontAwesome", size: 20)
            btnFilter.setTitle("", for: .normal)
            
            btnFilter.addTarget(self, action: #selector(openFilter), for: UIControlEvents.touchUpInside)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnFilter)
            
            if let bottomMenuView = Bundle.main.loadNibNamed("BottomMenuUser", owner: nil, options: nil)?[0] as? UIView{
                bottomMenuView.frame.size.width = bottomMenu.frame.width
                bottomMenu.addSubview(bottomMenuView)
            }
        } else{
            navigationController?.navigationBar.isHidden = true
            
            let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
            bottomMenu.addSubview(bottomMenuView)
        }
    }
    
    @objc func openFilter(){
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
    
    func loadTopBanner(){
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Alamofire.request("http://api.rumahhokie.com/prm_banner_top?schedule=now", method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    if let result = json as? [String:AnyObject] {
                        if let detail = result["prm_banner_top"]{
                            if let d = detail as? Array<AnyObject>{
                                for array in d{
                                    let resImage = array.value(forKey: "prm_top_image") as! String
                                    let resUrl = array.value(forKey: "prm_top_url") as! String
                                    let resTitle = array.value(forKey: "prm_top_cust") as! String
                                    
                                    self.url.append(resUrl+resImage)
                                    self.titleArray.append(resTitle)
                                }
                            }
                        }
                    }
                }
                
                let pathArray = self.url
                self.carouselView.delegate = self
                self.carouselView.setCarouselData(paths: pathArray,  describedTitle: self.titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "defaultImage")
                self.carouselView.setCarouselOpaque(layer: true, describedTitle: true, pageIndicator: false)
                self.carouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 4, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
                
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
        UIApplication.shared.open(URL(string: "http://rumahhokie.com")!, options: [:])
    }
    
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        imageView.kf.setImage(with: URL(string: url[index]), placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
    }
    
    func downloadImages(_ url: String, _ index: Int) {
        let imageView = UIImageView()
        let urlAppended = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        imageView.kf.setImage(with: URL(string: urlAppended!)!, placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            self.carouselView.images[index] = downloadImage!
        })
    }
    
    func loadTopListing(){
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Alamofire.request("http://api.rumahhokie.com/cnt_top_listing?view=short&offset=0&limit=10&order_by=cnt_listing_publish_on&order_type=desc", method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    var countResult: Int = 0
                    if let res = (json as AnyObject).value(forKey: "cnt_listing"){
                        if let resArray = res as? Array<AnyObject>{
                            for r in resArray{
                                countResult = countResult + 1
                                self.topListingArray.append(r)
                            }
                            
                            for i in 0 ..< countResult{
                                let listingView = Bundle.main.loadNibNamed("TopListing", owner: nil, options: nil)![0] as! UIView
                                listingView.frame.size.width = self.view.frame.width
                                
                                let viewWidth = self.view.frame.width
                                let xVar = CGFloat(i) * viewWidth
                                
                                let totalViewWidth = CGFloat(countResult) * viewWidth
                                
                                self.constraintTopListingViewWidth.constant = CGFloat(totalViewWidth)
                                
                                listingView.frame = CGRect(x: xVar, y: 0, width: viewWidth, height: 350)
                                
                                if let label2 = listingView.viewWithTag(2) as? UILabel{
                                    if let cntListName = (self.topListingArray[i] as AnyObject).value(forKey: "cnt_listing_name"){
                                        label2.text = cntListName as? String
                                    }
                                }
                                
                                if let label3 = listingView.viewWithTag(3) as? UILabel{
                                    if let cntWilayah = (self.topListingArray[i] as AnyObject).value(forKey: "mstr_wilayah"), let cntKota = (self.topListingArray[i] as AnyObject).value(forKey: "mstr_kota"), let cntProvinsi = (self.topListingArray[i] as AnyObject).value(forKey: "mstr_provinsi") {
                                        
                                        if let cntWilayahDetail = cntWilayah as? [String:AnyObject], let cntKotaDetail = cntKota as? [String:AnyObject], let cntProvinsiDetail = cntProvinsi as? [String:AnyObject]{
                                            label3.text = cntWilayahDetail["mstr_wilayah_desc"]! as! String + ", " + (cntKotaDetail["mstr_kota_desc"]! as! String) + ", " +  (cntProvinsiDetail["mstr_provinsi_desc"]! as! String)
                                        }
                                    }
                                }
                                
                                if let label4 = listingView.viewWithTag(4) as? UILabel{
                                    if let cntPrice = (self.topListingArray[i] as AnyObject).value(forKey: "cnt_listing_harga"){
                                        let cntPriceInt = cntPrice as! Int
                                        
                                        var textPrice: String = ""
                                        var priceFinal: Float = 0
                                        
                                        if (cntPriceInt / 1000000000) >= 1{
                                            textPrice = "M"
                                            priceFinal = Float(cntPriceInt / 1000000000)
                                        } else{
                                            textPrice = "juta"
                                            priceFinal = Float(cntPriceInt / 1000000)
                                        }
                                        
                                        if let label10 = listingView.viewWithTag(10) as? UILabel{
                                            label10.text = textPrice
                                        }
                                        
                                        label4.text = String(format: "%.2f", priceFinal)
                                    }
                                }
                                
                                if let label5 = listingView.viewWithTag(5) as? UILabel{
                                    if let cntBuildingArea = (self.topListingArray[i] as AnyObject).value(forKey: "cnt_listing_lb"){
                                        let cntBuildingAreaInt = cntBuildingArea as! Int
                                        label5.text = String(cntBuildingAreaInt)
                                    }
                                }
                                    
                                if let label6 = listingView.viewWithTag(6) as? UILabel{
                                    if let cntGroundArea = (self.topListingArray[i] as AnyObject).value(forKey: "cnt_listing_lt"){
                                        let cntGroundAreaInt = cntGroundArea as! Int
                                        label6.text = String(cntGroundAreaInt)
                                    }
                                }
                                
                                if let lbl1 = listingView.viewWithTag(1) as? UIImageView{
                                    if let cntFoto = (self.topListingArray[i] as AnyObject).value(forKey: "cnt_foto"){
                                        if let resPhoto = cntFoto as? Array<AnyObject>{
                                            if let photoName = resPhoto[0].value(forKey: "nama_foto") as? String{
                                                let pictUrl = URL(string: "http://rumahhokie.com/upload-foto/"+photoName )!
                                                
                                                DispatchQueue.global().async {
                                                    if let data = try? Data(contentsOf: pictUrl){
                                                        if let dataImage = UIImage(data: data){
                                                            DispatchQueue.main.async {
                                                                
                                                                lbl1.image = dataImage
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                self.topListingView.addSubview(listingView)
                                
                                self.constraintTopListingViewWidth.constant = viewWidth * CGFloat(countResult)
                            }
                        }
                    }
                }
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
    }
    
}
