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
    
    
    var url = [String]()
    var titleArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTopBanner()
        
        self.navigationController?.navigationBar.isHidden = true;
        let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
        bottomMenu.addSubview(bottomMenuView)
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
    
    
}
