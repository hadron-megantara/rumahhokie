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
