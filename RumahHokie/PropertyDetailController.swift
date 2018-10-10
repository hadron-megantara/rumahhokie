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
                print(self.idDetail)
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
}
