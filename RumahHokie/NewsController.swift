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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
