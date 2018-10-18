//
//  SideBar.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 18/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class SideBar: UITableViewCell {
    
    @IBOutlet weak var addAdvertisement: UIButton!
    @IBOutlet weak var advertisementPublic: UIButton!
    @IBOutlet weak var advertisementSold: UIButton!
    @IBOutlet weak var advertisementBlock: UIButton!
    
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    var navigationController:UINavigationController = UINavigationController()
    
    @IBAction func addAdvertisementAction(_ sender: Any) {
        let vc = storyboard.instantiateViewController(withIdentifier: "addAdvertisementView") as? AddAdvertisementController
        navigationController.pushViewController(vc!, animated: true)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    @IBAction func advertisementPublicAction(_ sender: Any) {
        
    }
    
    @IBAction func advertisementSold(_ sender: Any) {
        
    }
    
    @IBAction func advertisementBlocked(_ sender: Any) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
