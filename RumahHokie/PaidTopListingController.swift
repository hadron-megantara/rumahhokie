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
    
    var sideIsOpened: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        if UserDefaults.standard.object(forKey: "User") != nil{
            navigationController?.navigationBar.isHidden = false
            self.navigationItem.title = "Top Listing Berbayar"
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 34/255, green: 54/255, blue: 128/255, alpha: 1.0)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
            let btnFilter = UIButton(type: .custom)
            btnFilter.titleLabel?.font = UIFont(name: "FontAwesome", size: 20)
            btnFilter.setTitle("", for: .normal)
            
            btnFilter.addTarget(self, action: #selector(openFilter), for: UIControlEvents.touchUpInside)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnFilter)
            
            if let bottomMenuView = Bundle.main.loadNibNamed("BottomMenuUser", owner: nil, options: nil)?[0] as? UIView{
                bottomMenuView.frame.size.width = bottomMenu.frame.width
                bottomMenu.addSubview(bottomMenuView)
            }
        } else{
            navigationController?.navigationBar.isHidden = true
            
            let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
            bottomMenu.addSubview(bottomMenuView)
        }
    }
    
    @objc func openFilter(){
        if(!sideIsOpened){
            sideIsOpened = true
            let sideMenu = Bundle.main.loadNibNamed("SideBar", owner: nil, options: nil)![0] as! UIView
            sideMenu.frame.size.width = self.view.frame.width * 4/5
            sideMenu.frame.size.height = self.view.frame.height
            sideMenu.tag = 100
            
            self.view.superview?.isUserInteractionEnabled = true
            self.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
            
            UIView.transition(with: self.view, duration: 0.5, options:[],animations: {self.view.addSubview(sideMenu)}, completion: nil)
        } else{
            sideIsOpened = false
            let sideView = view.viewWithTag(100)
            sideView?.removeFromSuperview()
        }
    }
    
    @objc func alertControllerBackgroundTapped(){
        sideIsOpened = false
        let sideView = view.viewWithTag(100)
        sideView?.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
