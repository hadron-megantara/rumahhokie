//
//  BottomMenu.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 13/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class BottomMenu: UITableViewCell {
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    var navigationController:UINavigationController = UINavigationController()
    
    @IBAction func homeBtn(_ sender: UIButton) {
        let vc = storyboard.instantiateViewController(withIdentifier: "homeView") as? HomeController
        navigationController.pushViewController(vc!, animated: true)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    @IBAction func newsBtn(_ sender: UIButton) {
        let vc = storyboard.instantiateViewController(withIdentifier: "newsView") as? NewsController
        navigationController.pushViewController(vc!, animated: true)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    @IBAction func agentBtn(_ sender: UIButton) {
        let vc = storyboard.instantiateViewController(withIdentifier: "agentView") as? AgentController
        navigationController.pushViewController(vc!, animated: true)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    @IBAction func userBtn(_ sender: UIButton) {
        let vc = storyboard.instantiateViewController(withIdentifier: "userView") as? UserController
        navigationController.pushViewController(vc!, animated: true)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
