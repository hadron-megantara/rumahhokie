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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bottomMenuView = Bundle.main.loadNibNamed("BottomMenuUser", owner: nil, options: nil)![0] as! UIView
        bottomMenuView.frame.size.width = bottomMenu.frame.width
        bottomMenu.addSubview(bottomMenuView)
        
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
