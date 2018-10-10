//
//  PropertyDetailController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 19/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import Alamofire

class PropertyDetailController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var carouselView: UIView!
    
    @IBAction func backButtonAction(_ sender: Any) {
        let switchViewController = self.navigationController?.viewControllers[1] as! PropertyListController
        
        self.navigationController?.popToViewController(switchViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnShare = UIButton(type: .custom)
        btnShare.setImage(UIImage(named: "shareIconBlack"), for: [])
        //        btn_filter.addTarget(self, action: #selector(PPTrainSearchResultViewController.showFilter), for: UIControlEvents.touchUpInside)
        navItem.rightBarButtonItem = UIBarButtonItem(customView: btnShare)
    }
}
