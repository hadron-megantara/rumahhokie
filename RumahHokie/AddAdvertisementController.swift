//
//  AddAdvertisementController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 18/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class AddAdvertisementController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: Any) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "advertisementListView") as? AdvertisementListController
        navigationController!.pushViewController(vc!, animated: true)
    }
    
}
