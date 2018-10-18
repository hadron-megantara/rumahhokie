//
//  BottomMenuUser.swift
//  
//
//  Created by Hadron Megantara on 12/10/18.
//

import Foundation
import UIKit

class BottomMenuUser: UITableViewCell {
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    var navigationController:UINavigationController = UINavigationController()
    
    @IBAction func advertisementAction(_ sender: UIButton) {
        let vc = storyboard.instantiateViewController(withIdentifier: "advertisementListView") as? AdvertisementListController
        navigationController.pushViewController(vc!, animated: true)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    @IBAction func newsAction(_ sender: UIButton) {
        let vc = storyboard.instantiateViewController(withIdentifier: "newsView") as? NewsController
        navigationController.pushViewController(vc!, animated: true)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        let vc = storyboard.instantiateViewController(withIdentifier: "homeView") as? HomeController
        navigationController.pushViewController(vc!, animated: true)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    @IBAction func topListingAction(_ sender: UIButton) {
        let vc = storyboard.instantiateViewController(withIdentifier: "paidTopListingView") as? PaidTopListingController
        navigationController.pushViewController(vc!, animated: true)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    @IBAction func accountAction(_ sender: UIButton) {
        if UserDefaults.standard.object(forKey: "User") != nil{
            let vc = storyboard.instantiateViewController(withIdentifier: "userAccountView") as? UserAccountController
            navigationController.pushViewController(vc!, animated: true)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        } else{
            let vc = storyboard.instantiateViewController(withIdentifier: "userView") as? UserController
            navigationController.pushViewController(vc!, animated: true)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
