//
//  UserAccountController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 14/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class UserAccountController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userJoinedFrom: UILabel!
    @IBOutlet weak var userPropertyTotal: UILabel!
    @IBOutlet weak var userPropertySold: UILabel!
    @IBOutlet weak var bottomMenu: BottomMenu!
    
    var sideIsOpened: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let decoded  = UserDefaults.standard.object(forKey: "User") as! Data
        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded)
        
        userName.text = (decodedTeams as AnyObject).value(forKey: "agt_name") as? String
        
        let propertyTotal: Int = (decodedTeams as AnyObject).value(forKey: "published_cnt_listing_count") as! Int
        let propertySold: Int = (decodedTeams as AnyObject).value(forKey: "sold_cnt_listing_count") as! Int
        print(propertyTotal)
        userPropertyTotal.text = String(propertyTotal)
        userPropertySold.text = String(propertySold)
        
        let pictUrl = URL(string: "http://rumahhokie.com/"+((decodedTeams as AnyObject).value(forKey: "agt_image") as? String)!)!
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: pictUrl){
                if let dataImage = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.userImg.image = dataImage
                    }
                }
            }
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        
        if UserDefaults.standard.object(forKey: "User") != nil{
            navigationController?.navigationBar.isHidden = false
            self.navigationItem.title = "Akun"
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
    
    @IBAction func logoutAction(_ sender: Any) {
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey:"User")
        
        let vc = storyboard!.instantiateViewController(withIdentifier: "homeView") as? HomeController
        navigationController!.pushViewController(vc!, animated: true)
    }
    
    @IBAction func resetPasswordAction(_ sender: Any) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "resetPasswordView") as? ResetPasswordController
        navigationController!.pushViewController(vc!, animated: true)
    }
    
}
