//
//  PropertyListController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 19/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class PropertyListController: UIViewController {
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var type: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if type == 1{
            navItem.title = "Rumah"
        } else if type == 2{
            navItem.title = "Apartemen"
        } else if type == 3{
            navItem.title = "Properti Baru"
        } else if type == 4{
            navItem.title = "Komersial"
        } else if type == 5{
            navItem.title = "Tanah"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
