//
//  AgentList.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 11/10/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit

class AgentList: UITableViewCell {
    @IBOutlet weak var agentName: UILabel!
    @IBOutlet weak var propertyList: UILabel!
    @IBOutlet weak var propertySold: UILabel!
    @IBOutlet weak var joinedFrom: UILabel!
    @IBOutlet weak var agentImage: UIImageView!
    @IBOutlet weak var constraintContactHeight: NSLayoutConstraint!
    @IBOutlet weak var contactAgent: UIView!
    @IBOutlet weak var btnContactMsg: UIButton!
    @IBOutlet weak var btnContactPhone: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func contactMsgAction(_ sender: UIButton) {
        let sms: String = "sms:+"+String(self.btnContactMsg.accessibilityIdentifier!)
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
    
    @IBAction func contactPhoneAction(_ sender: UIButton) {
        guard let url = URL(string: "tel://" + String(self.btnContactPhone.accessibilityIdentifier!)) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
