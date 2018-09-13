//
//  BottomMenu.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 13/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import UIKit

protocol CustomViewDelegate: class {
    func goToNextScene()
}

class BottomMenu: UITableViewCell {
    @IBAction func homeBtn(_ sender: UIButton) {
        delegate?.goToNextScene()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
