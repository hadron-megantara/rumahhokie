//
//  AgentController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 13/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import UIKit

class AgentController: UIViewController {
    @IBOutlet weak var bottomMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    class func instanceFromNib() -> AgentController {
        return UINib(nibName: "BottomMenu", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AgentController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
