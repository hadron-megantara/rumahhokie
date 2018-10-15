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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
