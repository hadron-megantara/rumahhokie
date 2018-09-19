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
    @IBOutlet weak var tableView: UITableView!
    
    var type: Int = 1
    
    @IBAction func backToHome(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
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
        
        let btnFilter = UIButton(type: .custom)
        btnFilter.setImage(UIImage(named: "filterIconWhite"), for: [])
//        btn_filter.addTarget(self, action: #selector(PPTrainSearchResultViewController.showFilter), for: UIControlEvents.touchUpInside)
        navItem.rightBarButtonItem = UIBarButtonItem(customView: btnFilter)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 1000
        self.tableView.register(UINib(nibName: "EmptyListViewCell", bundle: nil), forCellReuseIdentifier: "EmptyListViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
