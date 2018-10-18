//
//  AdvertisementListController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 18/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class AdvertisementListController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bottomMenu: BottomMenu!
    @IBOutlet weak var whiteLineNew: UIView!
    @IBOutlet weak var whiteLineMost: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bottomMenuView = Bundle.main.loadNibNamed("BottomMenuUser", owner: nil, options: nil)![0] as! UIView
        bottomMenuView.frame.size.width = bottomMenu.frame.width
        bottomMenu.addSubview(bottomMenuView)
        
        whiteLineNew.backgroundColor = UIColor.white
        whiteLineMost.backgroundColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func showSideBar(_ sender: Any) {
        let sideMenu = Bundle.main.loadNibNamed("SideBar", owner: nil, options: nil)![0] as! UIView
        sideMenu.frame.size.width = mainView.frame.width * 4/5
        sideMenu.frame.size.height = mainView.frame.height
        
        UIView.transition(with: mainView, duration: 0.5, options:[],animations: {self.mainView.addSubview(sideMenu)}, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
