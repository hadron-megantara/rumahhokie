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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
        bottomMenu.addSubview(bottomMenuView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
