//
//  AgentController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 13/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import UIKit
import Alamofire

class AgentController: UIViewController {
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var agentArray: Array = [Any]()
    var dataTotal: Int = 0
    var selectedIndex : Int = -1
    var wasSelectedIndex : Int = -1
    var wasHidden : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAgent()
        
        tableView.register(UINib(nibName: "AgentList", bundle: nil), forCellReuseIdentifier: "cellListAgent")
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
    
    func loadAgent(){
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Alamofire.request("http://api.rumahhokie.com/agt_user?offset=0&limit=100&order_by=popularity&order_type=desc", method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    if let res = (json as AnyObject).value(forKey: "agt_user"){
                        if let resArray = res as? Array<AnyObject>{
                            for r in resArray{
                                self.dataTotal = self.dataTotal + 1
                                
                                var dataName: String = ""
                                var dataJoinedFrom: String = ""
                                var dataPropertyList: Int = 0
                                var dataPropertySold: Int = 0
                                var dataImg: String = ""
                                
                                if let objName = r["agt_name"] as? String {
                                    dataName = objName
                                }
                                
                                if let objJoinedFrom = r["agt_created_on"] as? String {
                                    dataJoinedFrom = objJoinedFrom
                                }
                                
                                if let objPropertyList = r["published_cnt_listing_count"] as? Int {
                                    dataPropertyList = objPropertyList
                                }
                                
                                if let objPropertySold = r["sold_cnt_listing_count"] as? Int {
                                    dataPropertySold = objPropertySold
                                }
                                
                                if let objImg = r["agt_image"] as? String {
                                    dataImg = "http://rumahhokie.com/"+objImg
                                }
                                
                                let returnArray = [dataName, dataPropertyList, dataPropertySold, dataJoinedFrom, dataImg] as [Any]
                                self.agentArray.append(returnArray)
                            }
                        }
                    }
                }
                
                self.tableView.reloadData()
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
        }
    }
    
}

extension AgentController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataTotal
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellListAgent", for: indexPath) as! AgentList
        
        if let objData = self.agentArray[indexPath.row] as? Array<AnyObject>{
            cell.agentName.text = objData[0] as? String
            cell.propertyList.text = objData[1].stringValue
            cell.propertySold.text = objData[2].stringValue
            cell.joinedFrom.text = objData[3] as? String
            
            let pictUrl = URL(string: objData[4] as! String)!
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: pictUrl){
                    if let dataImage = UIImage(data: data){
                        DispatchQueue.main.async {
                            cell.agentImage.image = dataImage
                        }
                    }
                }
            }
            
            cell.contactAgent.isHidden = true
            cell.constraintContactHeight.constant = 0
        }
        
        return cell
    }
}

extension AgentController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AgentList
        cell.contactAgent.isHidden = false
        cell.constraintContactHeight.constant = 30
        cell.frame.size.height = cell.frame.height + 30
        
        if(selectedIndex != -1){
            wasSelectedIndex = selectedIndex
        }
        
        selectedIndex = indexPath.row
        
        if(wasSelectedIndex != -1 && (wasHidden == 1 || selectedIndex != wasSelectedIndex)){
            let cell2 = tableView.cellForRow(at: [0, wasSelectedIndex]) as! AgentList
            cell2.contactAgent.isHidden = true
            cell2.constraintContactHeight.constant = 0
        }
        
        if selectedIndex == wasSelectedIndex{
            if wasHidden == 0{
                wasHidden = 1
            } else{
                wasHidden = 0
            }
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedIndex
        {
            if selectedIndex != wasSelectedIndex{
                return 134
            } else if selectedIndex == wasSelectedIndex && wasHidden == 1{
                return 134
            } else{
                return 104
            }
        }else{
            return 104
        }
    }
}
