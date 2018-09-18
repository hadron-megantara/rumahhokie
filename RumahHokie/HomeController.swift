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

class HomeController: UIViewController, AACarouselDelegate {
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var carouselView: AACarousel!
    
    var titleArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTopBanner()
        
        self.navigationController?.navigationBar.isHidden = true;
        let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
        bottomMenu.addSubview(bottomMenuView)
    }
    
    func loadTopBanner(){
        var url: String = "";
        var firstImage = true;
        
        Alamofire.request("http://api.rumahhokie.com/prm_banner_top?schedule=now").responseJSON { response in
            switch response.result{
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
            }
            
            if let json = response.result.value {
                print(json)
                
                if let result = json as? [String:AnyObject] {
                    if let detail = result["prm_banner_top"]{
                        if let d = detail as? Array<AnyObject>{
                            for array in d{
                                let resImage = array.value(forKey: "prm_top_image") as! String
                                let resUrl = array.value(forKey: "prm_top_url") as! String
                                print(firstImage)
                                if firstImage{
                                    url = resUrl + resImage
                                    firstImage = false
                                } else{
                                    url += "," + resUrl + resImage
                                }
                            }
                        }
                    }
                }
            }
        }
        print(url)
        
//        print(manager)
//        print(url)
//        let pathArray = [url]
//        titleArray = ["picture 1","picture 2","picture 3","picture 4","picture 5"]
//        carouselView.delegate = self
//        carouselView.setCarouselData(paths: pathArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "defaultImage")
//        //optional methods
//        carouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
//        carouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 5, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
        let alert = UIAlertView.init(title:"Alert" , message: titleArray[index], delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
    
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
    }
    
    func downloadImages(_ url: String, _ index: Int) {
        
    }
    
    
}
