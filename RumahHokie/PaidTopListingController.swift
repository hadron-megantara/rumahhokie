//
//  PaidTopListingController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 15/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class PaidTopListingController: UIViewController {
    @IBOutlet weak var bottomMenu: BottomMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bottomMenuView = Bundle.main.loadNibNamed("BottomMenuUser", owner: nil, options: nil)![0] as! UIView
        bottomMenuView.frame.size.width = bottomMenu.frame.width
        bottomMenu.addSubview(bottomMenuView)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func sideBarView(_ sender: Any) {
        let sideMenu = Bundle.main.loadNibNamed("SideBar", owner: nil, options: nil)![0] as! UIView
        sideMenu.frame.size.width = self.view.frame.width * 4/5
        sideMenu.frame.size.height = self.view.frame.height
        
        UIView.transition(with: self.view, duration: 0.5, options:[],animations: {self.view.addSubview(sideMenu)}, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
