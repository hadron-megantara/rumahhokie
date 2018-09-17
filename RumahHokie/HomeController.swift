//
//  HomeController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 13/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import UIKit
import AACarousel

class HomeController: UIViewController {
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var carouselView: AACarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTopBanner()
        
        self.navigationController?.navigationBar.isHidden = true;
        let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
        bottomMenu.addSubview(bottomMenuView)
    }
    
    func loadTopBanner(){
        let manager = AFHTTPSessionManager(baseURL: URL(string: "http://api.rumahhokie.com"))
        
        let params = [
            "schedule": "now"
        ]
        
//        var url: String = ""
        
        manager.get(
            "/prm_banner_top",
            parameters: params,
            success:
            {
                (task: URLSessionDataTask!, result: Any) in
                
                if let res = result as? [String:Any] {
                    if let detail = res["prm_banner_top"]{
                        if let d = detail as? Array<Any>{
                            for array in d{
                                if let json = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : AnyObject] {
                                
                                }
                                
                                print(a)
                                
//                                let b = array["prm_top_url"] + array["prm_top_image"]
//                                url += array["prm_top_url"] + array["prm_top_image"] + ","
                            }
                        }
                    }
                }
            },
            failure:
            {
                (operation, error) in
                print("Error: " + error.localizedDescription)
            }
        )
        
//        let pathArray = []
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
    
    
}
