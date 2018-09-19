//
//  NewsController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 13/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import UIKit
import Alamofire

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
        
        loadNews()
    }
    
    func loadNews(){
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Alamofire.request("http://rumahhokie.com/beritaproperti/wp-json/wp/v2/posts?categories=258&offset=1&per_page=2&_embed=1", method: .get).responseJSON { response in
                if let json = response.result.value {
                    print(json)
                    if let result = json as? [String:AnyObject] {
                        print(result)
                    }
                }
                
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
    
    
}
