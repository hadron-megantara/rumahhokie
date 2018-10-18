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
    @IBOutlet weak var propertyViewSold: UIView!
    @IBOutlet weak var propertyViewRent: UIView!
    @IBOutlet weak var radioPropertyStatusSold: UIImageView!
    @IBOutlet weak var radioPropertyStatusRent: UIImageView!
    
    var propertyStatus: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewPropertySoldAction))
        propertyViewSold.addGestureRecognizer(gesture)
        
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(viewPropertyRentAction))
        propertyViewRent.addGestureRecognizer(gesture2)
    }
    
    @objc func viewPropertySoldAction(){
        propertyStatus = 1
        radioPropertyStatusSold.image = UIImage(named:"radio-btn-checked.png")
        radioPropertyStatusRent.image = UIImage(named:"radio-btn-unchecked.png")
    }
    
    @objc func viewPropertyRentAction(){
        propertyStatus = 2
        radioPropertyStatusRent.image = UIImage(named:"radio-btn-checked.png")
        radioPropertyStatusSold.image = UIImage(named:"radio-btn-unchecked.png")
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
