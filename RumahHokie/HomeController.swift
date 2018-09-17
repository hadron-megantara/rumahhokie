//
//  HomeController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 13/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var carouselView: AACarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let res = loadTopBanner()
        print(res)
        
        self.navigationController?.navigationBar.isHidden = true;
        let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
        bottomMenu.addSubview(bottomMenuView)
    }
    
    func loadTopBanner(){
        let manager = AFHTTPSessionManager(baseURL: URL(string: "http://rumahhokie.com"))
        
        let params = [
            "categories": "258",
            "offset": "1",
            "per_page": "20",
            "_embed": "1"
        ]
        
        manager.get(
            "/beritaproperti/wp-json/wp/v2/posts",
            parameters: params,
            success:
            {
                (task: URLSessionDataTask!, res: Any) in
                print(res)
            },
            failure:
            {
                (operation, error) in
                print("Error: " + error.localizedDescription)
            }
        )
        
        return manager
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
