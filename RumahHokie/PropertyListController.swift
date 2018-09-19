//
//  PropertyListController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 19/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PropertyListController: UIViewController {
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
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

extension PropertyListController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellListProperty", for: indexPath) as UITableViewCell
        
        if let label1 = cell.viewWithTag(1) as? UILabel{
            label1.text = "Rumah asri Murah exclusive di clust"
        }
        
        if let label2 = cell.viewWithTag(2) as? UILabel{
            label2.text = "Gekbrong, Cianjur, Jawa Barat"
        }
        
        if let label3 = cell.viewWithTag(3) as? UILabel{
            label3.text = "500"
        }
        
        if let label4 = cell.viewWithTag(4) as? UILabel{
            label4.text = "100"
        }
        
        if let label5 = cell.viewWithTag(5) as? UILabel{
            label5.text = "150"
        }
        
        if let label6 = cell.viewWithTag(6) as? UILabel{
            label6.text = "02:28"
        }
        
        if let label7 = cell.viewWithTag(7) as? UILabel{
            label7.text = "0"
        }
        
        return cell
    }
}

extension PropertyListController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
