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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.navigationBar.isHidden = true;
        let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
        bottomMenu.addSubview(bottomMenuView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension AgentController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellListAgent", for: indexPath) as UITableViewCell
        
        if let label1 = cell.viewWithTag(1) as? UILabel{
            label1.text = "VROffficers"
        }
        
        if let label2 = cell.viewWithTag(2) as? UILabel{
            label2.text = "0"
        }
        
        if let label3 = cell.viewWithTag(3) as? UILabel{
            label3.text = "0"
        }
        
        if let label4 = cell.viewWithTag(4) as? UILabel{
            label4.text = "Bergabung sejak hari ini"
        }
        
        cell.viewWithTag(6)?.isHidden = true
        
        return cell
    }
}

extension AgentController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
