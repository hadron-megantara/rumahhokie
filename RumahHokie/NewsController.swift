//
//  NewsController.swift
//  RumahHokie
//
//  Created by Hadron Megantara on 13/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

import UIKit
import Alamofire

class NewsController: UIViewController {
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var btnProperty: UIButton!
    @IBOutlet weak var btnNew: UIButton!
    @IBOutlet weak var btnPopular: UIButton!
    @IBOutlet weak var btnGalery: UIButton!
    @IBOutlet weak var btnVideo: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var dataTotal: Int = 0
    var newsArray: Array = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadNews()
        
        btnProperty.titleLabel?.adjustsFontSizeToFitWidth = true
        btnNew.titleLabel?.adjustsFontSizeToFitWidth = true
        btnPopular.titleLabel?.adjustsFontSizeToFitWidth = true
        btnGalery.titleLabel?.adjustsFontSizeToFitWidth = true
        btnVideo.titleLabel?.adjustsFontSizeToFitWidth = true
        
        self.navigationController?.navigationBar.isHidden = true
        
        if UserDefaults.standard.object(forKey: "User") != nil{
            let bottomMenuView = Bundle.main.loadNibNamed("BottomMenuUser", owner: nil, options: nil)![0] as! UIView
            bottomMenuView.frame.size.width = bottomMenu.frame.width
            bottomMenu.addSubview(bottomMenuView)
        } else{
            let bottomMenuView = Bundle.main.loadNibNamed("BottomMenu", owner: nil, options: nil)![0] as! UIView
            bottomMenu.addSubview(bottomMenuView)
        }
    }
    
    func loadNews(){
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Alamofire.request("http://rumahhokie.com/beritaproperti/wp-json/wp/v2/posts?&offset=1&per_page=20&_embed=1", method: .get).responseJSON { response in
                
                if let json = response.result.value {
                    if let resArray = json as? Array<AnyObject>{
                        for r in resArray{
                            self.dataTotal = self.dataTotal + 1
                            
                            var dataTitle: String = ""
                            var dataImage: String = ""
                            var dataDate: String = ""
                            
                            if let objTitle = r["title"] as? [String:AnyObject] {
                                dataTitle = objTitle["rendered"]! as! String
                            }
                            
                            if let objDate = r["date"] as? String {
                                dataDate = objDate
                            }
                            
                            if let objImage = r["_embedded"] as? [String:AnyObject] {
                                if let imgJson = objImage["wp:featuredmedia"] as? Array<AnyObject>{
                                    for imgArray in imgJson{
                                        if let objMediaDetail = imgArray["media_details"] as? [String:AnyObject] {
                                            if let objFull = objMediaDetail["sizes"]!.value(forKey: "full"){
                                                dataImage = (objFull as AnyObject).value(forKey: "source_url")! as! String
                                            }
                                        }
                                    }
                                }
                            }
                            
                            let returnArray = [dataTitle, dataImage, dataDate]
                            self.newsArray.append(returnArray)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension NewsController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataTotal
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellListNews", for: indexPath) as UITableViewCell
        
        if let objData = self.newsArray[indexPath.row] as? Array<AnyObject>{
            if let label1 = cell.viewWithTag(1) as? UIImageView{
                print(objData[1])
                if ((objData[1] as? String) != ""){
                    let pictUrl = URL(string: objData[1] as! String)!
                    
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: pictUrl){
                            if let dataImage = UIImage(data: data){
                                DispatchQueue.main.async {
                                    label1.image = dataImage
                                }
                            }
                        }
                    }
                }
            }
            
            if let label2 = cell.viewWithTag(2) as? UILabel{
                label2.text = objData[0] as? String
            }
            
            if let label3 = cell.viewWithTag(3) as? UILabel{
                label3.text = objData[2] as? String
            }
        }
        
        return cell
    }
}

extension NewsController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
