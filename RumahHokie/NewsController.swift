//
//  NewsController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 13/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import UIKit

class NewsController: UIViewController {
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var btnProperty: UIButton!
    @IBOutlet weak var btnNew: UIButton!
    @IBOutlet weak var btnPopular: UIButton!
    @IBOutlet weak var btnGalery: UIButton!
    @IBOutlet weak var btnVideo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnProperty.titleLabel?.adjustsFontSizeToFitWidth = true
        btnNew.titleLabel?.adjustsFontSizeToFitWidth = true
        btnPopular.titleLabel?.adjustsFontSizeToFitWidth = true
        btnGalery.titleLabel?.adjustsFontSizeToFitWidth = true
        btnVideo.titleLabel?.adjustsFontSizeToFitWidth = true
        
        self.navigationController?.navigationBar.isHidden = true
        let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
        bottomMenu.addSubview(bottomMenuView)
        
        getJSON()
    }
    
    func getJSON() {
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
